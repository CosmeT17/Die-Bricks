extends RigidBody2D

@export var start_speed: int = 280
@export var speedup: int = 10
@export var max_speed: int = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		if body.is_in_group("Bricks"):
			get_node("/root/Level").score += 5 * body.hp
			if body.hp == 1:
				body.queue_free()
			else:
				body.hp -= 1
			
		elif body.name == "Paddle":
			var speed = linear_velocity.length()
			var direction = position - body.get_node("Anchor").global_position
			var velocity = direction.normalized() * min(speed+speedup, max_speed)
			linear_velocity = velocity
	
	if position.y > get_viewport_rect().end.y:
		queue_free()
		var paddle = get_node("/root/Level").get_node("Paddle")
		paddle.arrow.rotation_degrees = paddle.rng.randi_range(-35, 125)
		paddle.get_node("Arrow").visible = true
		paddle.can_shoot = true
