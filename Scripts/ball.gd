extends RigidBody2D

const PARTICLES = {
	"Fireball": preload("res://Scenes/Fireball.tscn")
}
var Particle: GPUParticles2D = null: set = set_particle

@export var start_speed: int = 500
@export var speedup: int = 20
@export var max_speed: int = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	#set_particle(PARTICLES["Fireball"].instantiate())
	set_physics_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		if body.is_in_group("Bricks"):
			body.hits += 1
			get_parent().score += 5 * body.hits
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
		var Lives = get_node(("/root/Level/Lives"))
		Lives.lives -= 1
		
func set_particle(new_particle: GPUParticles2D):
	if Particle: Particle.queue_free()
	if new_particle: add_child(new_particle)
	Particle = new_particle
