extends RichTextLabel

const paddle_scene = preload("res://Scenes/Paddle.tscn")
var dialog = [
	"Welcome to Brick Destroyer!",
	"Move the paddle with the mouse.",
	"Left click to shoot the ball.",
	"Break as many bricks as you can as fast as possible.",
	"Thats all there is to it!",
	"Have fun! :)"
]
var page_num: int = 0
@onready var Instructions = $Instructions
@onready var Page = $Page

func _ready():
	visible_characters = 0
	text = dialog[page_num]
	Page.text = "%d/%d" % [page_num+1, dialog.size()]
	set_process_input(true)
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if visible_characters >= get_total_character_count():
				if page_num < dialog.size() - 1:
					page_num+= 1
					visible_characters = 0
					text = dialog[page_num]
					Page.text = "%d/%d" % [page_num+1, dialog.size()]
				else:
					pass
					get_parent().queue_free()
					var Paddle = paddle_scene.instantiate()
					Paddle.position = Vector2(get_viewport_rect().end.x/2, get_viewport_rect().end.y-24)
					get_tree().root.add_child(Paddle)
			else:
				visible_characters = get_total_character_count()

func _on_timer_timeout():
	if visible_characters < get_total_character_count():
		visible_characters += 1
	
	if page_num == 0 and visible_characters == get_total_character_count():
		Instructions.visible = true
	elif page_num != 0:
		Instructions.visible = false
