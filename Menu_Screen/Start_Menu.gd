extends Control


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level.tscn")


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Menu_Screen/Settings_Menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
