extends CharacterBody3D

enum States{
	patrol,
	chasing,
	hunting,
	waiting
}

@export var player_path : NodePath
@export var waypoints : Array[Marker3D]
@onready var navagent = $NavigationAgent3D

var currentstate: States
var player = null
const gravity = 9.8
const walkspeed = 3
const runspeed = 7
var waypointIndex : int
var playerinhearfar : bool
var playerinhearclose : bool
var playerinvisionfar : bool
var playerinvisionclose : bool


func _ready():
	navagent.set_target_position(waypoints[0].global_position)
	player = get_node(player_path)
func _process(delta):
	#Gravity
	#if not is_on_floor():
		#velocity.y -= gravity*delta
	
	
	match currentstate:
		States.patrol:
			if navagent.is_navigation_finished():
				currentstate = States.waiting
				$PatTimer.start()
				return
			$AnimationPlayer.play("Walk")
			movetwd(delta,walkspeed)
			pass
		States.chasing:
			if navagent.is_navigation_finished():
				$PatTimer.start()
				currentstate = States.waiting
			navagent.set_target_position(player.global_transform.origin)
			movetwd(delta,(runspeed*80))
			pass
		States.hunting:
			if navagent.is_navigation_finished():
				$PatTimer.start()
				currentstate = States.waiting
			movetwd(delta,walkspeed)
			pass
		States.waiting:
			checkforplayer()
			$AnimationPlayer.play("Idle")
			pass

	
func movetwd(delta, speed):
	var targpos = navagent.get_next_path_position()
	var direction = global_position.direction_to(targpos)
	faceDirection(targpos)
	velocity = direction*speed
	move_and_slide()
	if playerinhearfar:
		checkforplayer()
	
	#print(position)


func checkforplayer():
	var space_state = get_world_3d().direct_space_state
	var result = space_state.intersect_ray(PhysicsRayQueryParameters3D.create($Head.global_position,player.get_node("MainCam").global_position,1,[self]))
	if result.size()>0:
		if result["collider"] == player:
			if playerinhearclose:
				currentstate = States.chasing
			if playerinhearfar:
				currentstate = States.hunting
				navagent.set_target_position(player.global_transform.origin)
			if playerinvisionclose:
				currentstate = States.chasing
			if playerinvisionfar:
				currentstate = States.hunting
				navagent.set_target_position(player.global_transform.origin)

func faceDirection(direction : Vector3):
	look_at(Vector3(direction.x,global_position.y,direction.z), Vector3.UP)


func _on_pat_timer_timeout():
	currentstate = States.patrol
	waypointIndex += 1
	if waypointIndex > waypoints.size()-1:
		waypointIndex = 0
	navagent.set_target_position(waypoints[waypointIndex].global_position)
	
	pass # Replace with function body.


func _on_hearing_far_body_entered(body):
	if body == player:
		playerinhearfar = true
	pass # Replace with function body.


func _on_hearing_far_body_exited(body):
	if body == player:
		playerinhearfar = false
	pass # Replace with function body.


func _on_hearing_close_body_entered(body):
	if body == player:
		$AnimationPlayer.play("Run")
		playerinhearclose = true
	pass # Replace with function body.


func _on_hearing_close_body_exited(body):
	if body == player:
		playerinhearclose = false
		$AnimationPlayer.play("Walk")
	pass # Replace with function body.


func _on_vision_far_body_entered(body):
	if body == player:
		playerinvisionfar = true
	pass # Replace with function body.


func _on_vision_far_body_exited(body):
	if body == player:
		playerinvisionfar = false
	pass # Replace with function body.


func _on_vision_close_body_entered(body):
	if body == player:
		playerinvisionclose = true
	pass # Replace with function body.


func _on_vision_close_body_exited(body):
	if body == player:
		playerinvisionclose = false
	pass # Replace with function body.
