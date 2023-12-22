extends Node2D

var score: int = 0: set = set_score, get = get_score
@export var lives: int = 3: set = set_lives, get = get_lives
@onready var Hearts = $Lives/Hearts

func _ready():
	Hearts.frame = lives

func set_score(value: int):
	score = value
	get_node("Score").text = "Score: " + str(score)
	
func get_score():
	return score

func set_lives(value: int):
	lives = value
	if Hearts:
		Hearts.frame = lives

func get_lives():
	return lives
