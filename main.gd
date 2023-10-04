extends Node2D
@onready var animation_player = $AnimationPlayer
@onready var start_timer = $Timer
@onready var background_music = $BackgroundMusic
@onready var sfx_player = $SFXPlayer
@onready var path_follow_2d = $Path2D/PathFollow2D
@onready var animation_player_2 = $AnimationPlayer2
var battle_music = load("res://Sounds/Music/19 Expert Bonus Level.mp3")
var start_music = load("res://Sounds/Music/10 Level Map Select of LEVEL 2 LOOP.mp3")
var start_game:bool = false;
@export var kirby_scene:PackedScene
@export var king_dedede:PackedScene
var kirby
var kirby_spawn_location
var king
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("restart") and start_game:
		restart()
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
	kirby = kirby_scene.instantiate()
	path_follow_2d.add_child(kirby)
	#var kirby_node = get_node()
	kirby.connect("bounced",_on_kirby_bounced)
	
	background_music.stream=battle_music
	background_music.play()
	

func _on_kirby_bounced():
	animation_player.play("Intro")
	spawn_king()

func restart():
	if king ==null:
		return
	start_game = false;
	path_follow_2d.progress_ratio=0
	animation_player.play("starting_menu")
	kirby.queue_free()
	king.queue_free()
	background_music.stop()
	background_music.stream=start_music
	background_music.play()

func spawn_king():
	king = king_dedede.instantiate()
	add_child(king)
	animation_player_2.play("start_gp")

