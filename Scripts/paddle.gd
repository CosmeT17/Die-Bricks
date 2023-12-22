extends CharacterBody2D

const ball_scene = preload("res://Scenes/Ball.tscn")
var rng = RandomNumberGenerator.new()
var can_shoot: bool = true

@onready var Arrow = $Arrow
@onready var Direction = Arrow.get_node("Direction")

@export var arrow_speedup: int = 3
@export var clockwise: bool = true

func _ready():
	set_physics_process(true)
	set_process_input(true)
	
	rng.randomize()
	Arrow.rotation_degrees = rng.randi_range(-35, 125)
		
func _physics_process(delta):
	var y = get_position().y
	var mouse_x = get_viewport().get_mouse_position().x
	set_position(Vector2(mouse_x, y))
	
	if can_shoot:
		if clockwise and Arrow.rotation_degrees < 125:
			Arrow.rotation_degrees += arrow_speedup
			if Arrow.rotation_degrees >= 125:
				clockwise = false			
		elif not clockwise and Arrow.rotation_degrees > -35:
			Arrow.rotation_degrees -= arrow_speedup
			if Arrow.rotation_degrees <= -35:
				clockwise = true
		elif Arrow.rotation_degrees == 125: clockwise = false
		else: clockwise = true

func _input(event):
	if can_shoot:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				Arrow.visible = false
				var Ball = ball_scene.instantiate()
				Ball.tree_exited.connect(self.shoot_ball)
				Ball.position = position - Vector2(0,20)
				var direction_vector = Direction.global_position - Ball.global_position
				Ball.linear_velocity = direction_vector.normalized() * Ball.start_speed				
				get_parent().add_child(Ball)
				can_shoot = false

func shoot_ball():
	Arrow.rotation_degrees = rng.randi_range(-35, 125)
	Arrow.visible = true
	can_shoot = true
