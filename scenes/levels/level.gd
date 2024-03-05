extends Node3D


func _ready():
	if !GlobalVariables.hurdelsExist:
		$hurdles.queue_free()
	if GlobalVariables.hideRADAR:
		$Stat_Disp/RADAR_MINIMAP.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pause_menu()
	rplay($EnviorSounds/OwlSounds/O1a)
	rplay($EnviorSounds/OwlSounds/O2a)
	rplay($EnviorSounds/OwlSounds/O3a)
	rplay($EnviorSounds/OwlSounds/O4a)
	pplay($EnviorSounds/CricSounds/C1a)
	pplay($EnviorSounds/CricSounds/C1a2)
	pplay($EnviorSounds/CricSounds/C1a3)
	pplay($EnviorSounds/CricSounds/C2a)
	pplay($EnviorSounds/CricSounds/C2a2)
	pplay($EnviorSounds/CricSounds/C3a)
	pplay($EnviorSounds/CricSounds/C3a2)
	pplay($EnviorSounds/CricSounds/C3a3)

func pplay(s):
	if (not s.is_playing()):
		s.play()

func rplay(s):
	await get_tree().create_timer(60).timeout
	var a = randi() % 100
	if a == 0:
		if (not s.is_playing()):
			s.play()


func pause_menu():
	if GlobalVariables.paused:
		$PauseMenu.hide()
		Engine.time_scale = 1
	else:
		$PauseMenu.show()
		Engine.time_scale = 0
		
	GlobalVariables.paused = !GlobalVariables.paused
