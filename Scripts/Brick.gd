extends StaticBody2D

@export var hp: int = 1: set = set_hp, get = get_hp
@onready var Brick = $Brick
var hits: int = 0

func set_hp(value: int) -> void:
	hp = value
	if Brick:
		Brick.frame = hits

func get_hp() -> int:
	return hp
