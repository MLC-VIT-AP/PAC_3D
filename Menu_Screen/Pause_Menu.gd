extends Control

@onready var level = $"../"


func showNhide(first,second):
	first.show()
	second.hide()

func _process(delta):
	if GlobalVariables.paused:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_resume_button_pressed():
	level.pause_menu()


func _on_main_menu_button_pressed():
	showNhide($MarginContainer/ToMainMenu,$MarginContainer/Pasuemain)


func _on_quit_button_pressed():
	showNhide($MarginContainer/ToQuit,$MarginContainer/Pasuemain)


func _on_main_menu_f_pressed():
	Engine.time_scale = 1
	GlobalVariables.paused = false
	get_tree().change_scene_to_file("res://Menu_Screen/Start_Menu.tscn")

func _on_quit_f_pressed():
	get_tree().quit()


func _on_return_m_pressed():
	showNhide($MarginContainer/Pasuemain,$MarginContainer/ToMainMenu)


func _on_return_q_pressed():
	showNhide($MarginContainer/Pasuemain,$MarginContainer/ToQuit)
