extends Control


func _process(delta):
	pass
	
func toggle():
	visible = !visible
	get_tree().paused = visible



func _on_general_button_pressed():
	showNhide($General,$SettingsMenu1)

func _on_video_button_pressed():
	pass

func showNhide(first,second):
	first.show()
	second.hide()


func _on_mouse_slider_value_changed(value):
	GlobalVariables.mouse_senstivity = value
	


func _on_back_f_gen_button_pressed():
	showNhide($SettingsMenu1,$General)







func _on_menu_return_button_pressed():
	get_tree().change_scene_to_file("res://Menu_Screen/Start_Menu.tscn")
