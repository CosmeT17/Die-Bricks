extends RigidBody2D

@export var speedup: int = 10
@export var maxspeed: int = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		if body.is_in_group("Bricks"):
			get_node("/root/World").score += 5*body.hp
			if body.hp == 1:
				body.queue_free()
			else:
				body.hp -= 1
			
		elif body.name == "Paddle":
			var speed = linear_velocity.length()
			var direction = position - body.get_node("Anchor").global_position
			var velocity = direction.normalized() * min(speed+speedup, maxspeed)
			linear_velocity = velocity
			#print(velocity.length())
	
	if position.y > get_viewport_rect().end.y:
		queue_free()
