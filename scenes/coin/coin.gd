extends Area3D

signal coincollected

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_y(deg_to_rad(80*delta))


func _on_body_entered(body):
	if body.name == "Pac_Man":
		$Timer.start()


func _on_timer_timeout():
	emit_signal("coincollected")
	queue_free()
