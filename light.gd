extends Sprite2D

@onready var light_animator = $light_animator

# Called when the node enters the scene tree for the first time.
func _ready():
	light_animator.play("flickering")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
