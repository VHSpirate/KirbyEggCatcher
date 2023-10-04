extends Sprite2D
@onready var shader_animator = $"Shader animator"


# Called when the node enters the scene tree for the first time.
func _ready():
	shader_animator.play("Spotlight")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
