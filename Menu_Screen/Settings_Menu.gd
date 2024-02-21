extends Control

func _ready():
	diff_items()

func diff_items():
	var difmen = $General/HBoxContainer/VBoxContainer2/DifficultyS
	difmen.add_item("Easy")
	difmen.add_item("Medium")
	difmen.add_item("Hard")
	difmen.add_item("Very Hard")

func toggle():
	visible = !visible
	get_tree().paused = visible

func _on_general_button_pressed():
	showNhide($General,$SettingsMenu1)

func _on_video_button_pressed():
	showNhide($Video,$SettingsMenu1)

func showNhide(first,second):
	first.show()
	second.hide()

func _on_mouse_slider_value_changed(value):
	GlobalVariables.mouse_senstivity = value

func _on_back_f_gen_button_pressed():
	showNhide($SettingsMenu1,$General)

func _on_menu_return_button_pressed():
	get_tree().change_scene_to_file("res://Menu_Screen/Start_Menu.tscn")


func _on_back_f_vid_button_pressed():
	showNhide($SettingsMenu1,$Video)


func _on_full_screen_toggled(toggled_on):
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_difficulty_s_item_selected(index):
	if index == 0:
		GlobalVariables.demon_walk_speed = 80
		GlobalVariables.demon_run_speed = 250
	elif index == 1:
		GlobalVariables.demon_walk_speed = 100
		GlobalVariables.demon_run_speed = 280
	elif index == 2:
		GlobalVariables.demon_walk_speed = 110
		GlobalVariables.demon_run_speed = 310
	elif index == 3:
		GlobalVariables.demon_walk_speed = 125
		GlobalVariables.demon_run_speed = 320
