extends RigidBody2D

const SPEEDUP = 4
const MAXSPEED = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		if body.is_in_group("Bricks"):
			body.queue_free()
			
		elif body == get_node("../Paddle"):
			var speed = linear_velocity.length()
			#var direction = 
		
