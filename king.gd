extends Sprite2D
@onready var shader_animator = $"Shader animator"
@export var egg:PackedScene
@export var bomb:PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()  # This seeds the random number generator
	shader_animator.play("Spotlight")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("spawner"):
		spawn_random()

func spawn_random():
	if randi() % 2 == 0:
		spawn_egg()
	else:
		spawn_bomb()

func spawn_egg():
	var egg_spawn = egg.instantiate()
	add_child(egg_spawn)

func spawn_bomb():
	var bomb_spawn = bomb.instantiate()
	add_child(bomb_spawn)
