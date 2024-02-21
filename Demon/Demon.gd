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
var walkspeed = GlobalVariables.demon_walk_speed
var runspeed = GlobalVariables.demon_run_speed
var waypointIndex : int
var playerinhearfar : bool
var playerinhearclose : bool
var playerinvisionfar : bool
var playerinvisionclose : bool


func _ready():
	navagent.set_target_position(waypoints[(randi() %5)].global_position)
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
			if (not $Walksound.is_playing()):
				$Walksound.play()
			movetwd(delta,walkspeed*delta)
		States.chasing:
			if navagent.is_navigation_finished():
				$PatTimer.start()
				currentstate = States.waiting
			navagent.set_target_position(player.global_transform.origin)
			movetwd(delta,(runspeed*delta))
		States.hunting:
			if navagent.is_navigation_finished():
				$PatTimer.start()
				currentstate = States.waiting
			movetwd(delta,walkspeed*delta)
		States.waiting:
			checkforplayer()
			$AnimationPlayer.stop()
			$AnimationPlayer.play("Idle")
			if (not $IdleSound.is_playing()) or (not $Walksound.is_playing()):
				$IdleSound.play()

	
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
			if playerinvisionclose:
				currentstate = States.chasing
				if (not $RunSound.is_playing()):
					$RunSound.play()
			elif playerinhearclose and player.velocity:
				currentstate = States.chasing
			elif playerinvisionfar:
				currentstate = States.hunting
				navagent.set_target_position(player.global_transform.origin)
			elif playerinhearfar and player.velocity and (not Input.is_action_pressed("slow_down")):
				currentstate = States.hunting
				navagent.set_target_position(player.global_transform.origin)

func faceDirection(direction : Vector3):
	look_at(Vector3(direction.x,global_position.y,direction.z), Vector3.UP)


func _on_pat_timer_timeout():
	currentstate = States.patrol
	waypointIndex = randi() %5
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
		if not($AnimationPlayer.is_playing() and $AnimationPlayer.current_animation == "Fastjumpover"):
			$AnimationPlayer.stop()
		$AnimationPlayer.play("Run")
		playerinhearclose = true
	pass # Replace with function body.


func _on_hearing_close_body_exited(body):
	if body == player:
		playerinhearclose = false
		$AnimationPlayer.play("Walk")
		if (not $Walksound.is_playing()):
				$Walksound.play()
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

