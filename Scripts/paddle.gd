extends CharacterBody2D

const ball_scene = preload("res://Scenes/Ball.tscn")
var rng = RandomNumberGenerator.new()
var can_shoot: bool = true

@onready var arrow = $Arrow
@onready var direction = arrow.get_node("Direction")

@export var lives: int = 3
@export var arrow_speedup: int = 3
@export var clockwise: bool = true

func _ready():
	set_physics_process(true)
	set_process_input(true)
	
	rng.randomize()
	arrow.rotation_degrees = rng.randi_range(-35, 125)
		
func _physics_process(delta):
	var y = get_position().y
	var mouse_x = get_viewport().get_mouse_position().x
	set_position(Vector2(mouse_x, y))
	
	if can_shoot:
		if clockwise and arrow.rotation_degrees < 125:
			arrow.rotation_degrees += arrow_speedup
			if arrow.rotation_degrees >= 125:
				clockwise = false			
		elif not clockwise and arrow.rotation_degrees > -35:
			arrow.rotation_degrees -= arrow_speedup
			if arrow.rotation_degrees <= -35:
				clockwise = true
		elif arrow.rotation_degrees == 125: clockwise = false
		else: clockwise = true

func _input(event):
	if can_shoot:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				arrow.visible = false
				var ball = ball_scene.instantiate()
				ball.position = position - Vector2(0,10)
				var direction_vector = direction.global_position - ball.global_position
				ball.linear_velocity = direction_vector.normalized() * ball.start_speed
				get_tree().root.add_child(ball)
				can_shoot = false
