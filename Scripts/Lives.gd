extends Label

var lives: int = 3: set = set_lives, get = get_lives
@onready var Life_1 = $Life_1
@onready var Life_2 = $Life_2
@onready var Life_3 = $Life_3

func _ready():
	Life_1.visible = true
	Life_2.visible = true
	Life_3.visible = true

func set_lives(value):
	lives = value
	match lives:
		0:
			Life_1.visible = false
			Life_2.visible = false
			Life_3.visible = false
		1:
			Life_1.visible = true
			Life_2.visible = false
			Life_3.visible = false
		2:
			Life_1.visible = true
			Life_2.visible = true
			Life_3.visible = false
		3:
			Life_1.visible = true
			Life_2.visible = true
			Life_3.visible = true
		_:
			Life_1.visible = true
			Life_2.visible = true
			Life_3.visible = true

func get_lives():
	return lives
