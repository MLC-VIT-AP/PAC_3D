extends Node

@export var mouse_senstivity = 0.005
var paused = false
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var demon_walk_speed = 80
var demon_run_speed = 250
var hurdelsExist: bool
var hideRADAR: bool
