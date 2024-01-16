extends CharacterBody3D

var player = null
const gravity = 9.8

@export var player_path : NodePath
@onready var navagent = $NavigationAgent3D

func _ready():
	player = get_node(player_path)

func _physics_process(delta):
	
	#Set speed
	var SPEED = delta*320
	if not is_on_floor():
		velocity.y -= gravity*delta
	
	#Navigation
	velocity = Vector3.ZERO
	navagent.set_target_position(player.global_transform.origin)
	var nextnavpoint = navagent.get_next_path_position()
	velocity = (nextnavpoint-global_transform.origin).normalized()*SPEED
	#print(position)
	
	#Look towards the player
	look_at(Vector3(player.global_position.x,0,player.global_position.z),Vector3.UP)

	move_and_slide()
