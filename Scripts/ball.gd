extends RigidBody2D

const game_over_scene = preload("res://Scenes/World/Game_Over.tscn")
const PARTICLES = {
	"Fireball": preload("res://Scenes/Balls/Fireball.tscn")
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
func _physics_process(_delta):
	var Parent = get_parent()
	
	if get_tree().get_nodes_in_group("Bricks").size() == 0:
		game_over("Win")
		queue_free()
		
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		if body.is_in_group("Bricks"):
			body.hits += 1
			Parent.score += 5 * body.hits
			
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
		Parent.lives -= 1
		if Parent.lives < 1:
			game_over("Ded")

func set_particle(new_particle: GPUParticles2D) -> void:
	if Particle: Particle.queue_free()
	if new_particle: add_child(new_particle)
	Particle = new_particle

func game_over(msg: String) -> void:
	var Parent = get_parent()
	Parent.get_node("Paddle").queue_free()
	var Game_Over = game_over_scene.instantiate()
	Game_Over.get_node("Message").text = msg
	Parent.add_child(Game_Over)
