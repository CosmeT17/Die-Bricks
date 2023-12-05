extends StaticBody2D

const TEXTURES = {
	1: "res://Textures/Bricks/Brick-1.png",
	2: "res://Textures/Bricks/Brick-2.png",
	3: "res://Textures/Bricks/Brick-3.png",
	4: "res://Textures/Bricks/Brick-4.png",
	5: "res://Textures/Bricks/Brick-5.png",
}
@export var hp: int = 1: set = set_hp, get = get_hp

func set_hp(value):
	hp = value
	$Sprite.texture = load(TEXTURES[hp])

func get_hp():
	return hp
