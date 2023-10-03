extends Node2D
@onready var animation_player = $AnimationPlayer
@onready var start_timer = $Timer
@onready var kirby = $Path2D/PathFollow2D/Kirby
@onready var background_music = $BackgroundMusic
@onready var sfx_player = $SFXPlayer
"res://Sounds/Music/19 Expert Bonus Level.mp3"
var start_game:bool = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	kirby.set_physics_process(false)
	kirby.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(not start_game):
		if Input.is_action_just_released("continue"):
			sfx_player.play()
			background_music.stop()
			start()
		
		

func start():
	start_game	= true
	start_timer.start()
	animation_player.play("fadein")


func _on_timer_timeout():
	spawn_player()

func  spawn_player():
	#spawn player
	
	var battle_music = load("res://Sounds/Music/19 Expert Bonus Level.mp3")
	background_music.stream=battle_music
	background_music.play()
	kirby.set_physics_process(true)
	kirby.show()	

func _on_kirby_bounced():
	animation_player.play("Intro")

func restart():
	start_game = false;
	
