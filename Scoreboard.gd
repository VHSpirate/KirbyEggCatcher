extends CanvasGroup

@onready var score_box = $ScoreBox
@onready var first = $HBoxContainer/first
@onready var second = $HBoxContainer/second
@onready var third = $HBoxContainer/third
@onready var message = $Message
@onready var perfect = $perfect
@onready var perfectanimator = $perfect/perfectanimator

var first_texture
# Called when the node enters the scene tree for the first time.
func _ready():
	second.texture.region.position.x=68
func display_score(eggs):
	
	match eggs:
		0:
			message.frame = 1
			message.visible = true
		1: #100
			message.visible = true
			score_box.visible = true
			first.texture.region.position.x=32
			first.visible = true
			second.visible = true

		2,3: #200
			message.visible = true
			score_box.visible = true
			first.texture.region.position.x=40
			first.visible = true
			second.visible = true
		4,5,6: #300
			message.visible = true
			score_box.visible = true
			first.texture.region.position.x=48
			first.visible = true
			second.visible = true
		7,8,9: #500
			message.visible = true
			score_box.visible = true
			first.texture.region.position.x=56
			first.visible = true
			second.visible = true
		10,11,12,13: #1000
			message.visible = true
			score_box.visible = true
			first.texture.region.position.x=32
			first.visible = true
			second.visible = true
			third.visible = true
		14,15,16,17: #2000
			message.visible = true
			score_box.visible = true
			first.texture.region.position.x=40
			first.visible = true
			second.visible = true
			third.visible = true
		18,19,20,21: #3000
			message.visible = true
			score_box.visible = true
			first.texture.region.position.x=48
			first.visible = true
			second.visible = true
			third.visible = true
		22,23,24,25: #5000
			message.visible = true
			score_box.visible = true
			first.texture.region.position.x=56
			first.visible = true
			second.visible = true
			third.visible = true
		26,27: #1UP
			message.visible = true
			score_box.visible = true
			first.texture.region.position.x=32
			second.texture.region.position.x=96
			first.visible = true
			second.visible = true
			third.visible = false
		28,29: #2UP
			message.visible = true
			score_box.visible = true
			first.texture.region.position.x=40
			second.texture.region.position.x=96
			first.visible = true
			second.visible = true
			third.visible = false
		30: #3UP
			score_box.material=null
			perfect.visible = true
			perfectanimator.play("perfect")
			score_box.visible = true
			first.texture.region.position.x=48
			second.texture.region.position.x=96
			first.visible = true
			second.visible = true
			third.visible = false

