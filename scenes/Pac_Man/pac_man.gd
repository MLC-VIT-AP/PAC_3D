extends CharacterBody3D

var msens = GlobalVariables.mouse_senstivity
const JUMP_VELOCITY = 4
const DECELERATION_FACTOR = 0.5
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = GlobalVariables.gravity

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _physics_process(delta):
	var SPEED = delta*350
	var input_dir = Input.get_vector("left", "right", "front", "back") 
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	#Add gravity.
	if not is_on_floor():
		velocity.y -= gravity*delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY*60*delta
		
	#Slow down the charcter when pressed
	if Input.is_action_pressed("slow_down"):
		direction /= 3
		
	#Handle horizontal-movement
	if is_on_floor():
		if direction:
			if (not $Walk.is_playing()) and (not Input.is_action_pressed("slow_down")):
				$Walk.play()
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else :
			# Decelerate towards zero velocity on ground
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

	#print(velocity)

	move_and_slide()

func _input(event):
	#RotationMechanics
	if event is InputEventMouseMotion:
		rotation.x -= event.relative.y*msens
		rotation.x = clamp(rotation.x,deg_to_rad(-80),deg_to_rad(90))
		rotation.y -= event.relative.x*msens


func _on_demon_touch_body_entered(body):
	if body.name == "Pac_Man":
		get_tree().change_scene_to_file("res://Splash_Screens/game_over.tscn")
