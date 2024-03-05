extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE




func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level.tscn")


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Menu_Screen/Start_Menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
