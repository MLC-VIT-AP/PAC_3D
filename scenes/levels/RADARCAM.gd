extends Camera3D

@onready var player = $"../../../../../Pac_Man"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = Vector3(player.position.x,-2,player.position.z)
	rotation_degrees.y = player.rotation_degrees.y
