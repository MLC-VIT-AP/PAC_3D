extends Node3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pause_menu()
		


func pause_menu():
	if GlobalVariables.paused:
		$PauseMenu.hide()
		Engine.time_scale = 1
	else:
		$PauseMenu.show()
		Engine.time_scale = 0
		
	GlobalVariables.paused = !GlobalVariables.paused
