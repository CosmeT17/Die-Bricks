extends Node2D

var score: int = 0: set = set_score, get = get_score
	
func set_score(value):
	score = value
	get_node("Score").text = "Score: " + str(score)
	
func get_score():
	return score
