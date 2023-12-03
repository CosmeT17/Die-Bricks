extends CharacterBody2D

const ball_scene = preload("res://Scenes/Ball.tscn")

func _ready():
	set_physics_process(true)
	set_process_input(true)

func _physics_process(delta):
	var y = get_position().y
	var mouse_x = get_viewport().get_mouse_position().x
	set_position(Vector2(mouse_x, y))

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var ball = ball_scene.instantiate()
			ball.position = position - Vector2(0,16)
			get_tree().root.add_child(ball)
