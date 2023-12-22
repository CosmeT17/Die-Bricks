extends Node2D

var score: int = 0: set = set_score, get = get_score
@export var lives: int = 3: set = set_lives, get = get_lives
@onready var Hearts = $Lives/Hearts

func _ready():
	Hearts.frame = lives

func set_score(value: int) -> void:
	score = value
	get_node("Score").text = "Score: " + format_score(str(score))
	
func get_score() -> int:
	return score

func set_lives(value: int) -> void:
	lives = value
	if Hearts:
		Hearts.frame = lives

func get_lives() -> int:
	return lives

func format_score(val : String) -> String:
	var i : int = val.length() - 3
	while i > 0:
		val = val.insert(i, ",")
		i = i - 3
	return val
