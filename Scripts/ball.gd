extends RigidBody2D

const SPEEDUP = 400
const MAXSPEED = 30000

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		if body.is_in_group("Bricks"):
			body.queue_free()
			
		elif body.name == "Paddle":
			var speed = linear_velocity.length()
			var direction = position - body.get_node("Anchor").global_position
			var velocity = direction.normalized() * min(speed+SPEEDUP*delta, MAXSPEED*delta)
			linear_velocity = velocity
	
	if position.y > get_viewport_rect().end.y:
		queue_free()
