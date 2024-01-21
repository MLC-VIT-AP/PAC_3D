extends Label

var coins = 0

func _ready():
	text = str(coins)

func _on_coin_coincollected():
	coins += 1
	_ready()
	if coins == 10:
		$Timer.start()

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Splash_Screens/YouWon.tscn")
