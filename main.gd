extends Node2D
@onready var BackgroundAnimator = $BackgroundAnimator
@onready var start_timer = $PlayerSpawnTimer
@onready var background_music = $BackgroundMusic
@onready var sfx_player = $SFXPlayer
@onready var path_follow_2d = $Path2D/PathFollow2D
@onready var shaderAnimator = $ShaderAnimator
@onready var game_play_timer = $GamePlayTimer
@onready var egg_basket = $egg_basket
@onready var king_spawn = $king_spawn
@onready var explosion = $ColorRect/Explosion
@onready var display_timer = $displayTimer
var no_bonus = load("res://Sounds/Music/35 No Bonus.mp3")
var battle_music = load("res://Sounds/Music/19 Expert Bonus Level.mp3")
var start_music = load("res://Sounds/Music/10 Level Map Select of LEVEL 2 LOOP.mp3")
var bonus = preload("res://Sounds/Music/36 Bonus.mp3")
var perfect_bonus = preload("res://Sounds/Music/37 Perfect Bonus.mp3")
var start_game:bool = false;
@export var kirby_scene:PackedScene
@export var king_dedede:PackedScene
@export var egg_ui:PackedScene
@export var scoreboard:PackedScene
@onready var endtimer = $endtimer
@onready var __up = $"1up"

@onready var lamps = $lamps

var kirby
var kirby_spawn_location
var king
var egg_count: int = 0;
var board
# Called when the node enters the scene tree for the first time.
func _ready():
	BackgroundAnimator.play("intro_fade_in")
	
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
	game_play_timer.start()
	BackgroundAnimator.play("fadein")
	board = scoreboard.instantiate()
	add_child(board)

func _on_timer_timeout():
	spawn_player()
	lamps.visible = true

func  spawn_player():
	#spawn player
	kirby = kirby_scene.instantiate()
	path_follow_2d.add_child(kirby)
	#var kirby_node = get_node()
	kirby.connect("bounced",_on_kirby_bounced)
	kirby.connect("egg_eated",_add_egg_ui)
	kirby.connect("gg",_killed_kirb)
	game_play_timer.connect("timeout",kirby._on_game_play_timer)
	background_music.stream=battle_music
	background_music.play()
	

func _on_kirby_bounced():
	BackgroundAnimator.play("Intro")
	spawn_king()

func restart():
	if king == null:
		return
	endtimer.stop()
	display_timer.stop()
	BackgroundAnimator.play("intro_fade_in")
	start_game = false;
	path_follow_2d.progress_ratio=0
	BackgroundAnimator.play("RESET")
	shaderAnimator.play("RESET")
	kirby.queue_free()
	king.queue_free()
	board.queue_free()
	for child in egg_basket.get_children():
		child.queue_free()
	background_music.stop()
	background_music.stream=start_music
	background_music.play()
	egg_count=0
	endtimer.wait_time=10

func spawn_king():
	king = king_dedede.instantiate()
	king_spawn.add_child(king)
	game_play_timer.connect("timeout",king._on_game_play_timer)
	king.connect("done",_game_end)
	shaderAnimator.play("start_gp")
	
func _add_egg_ui(eggs):
	egg_count = eggs
	var egg = egg_ui.instantiate()
	egg_basket.add_child(egg)

func _game_end():
	display_timer.start()
	
	
func _killed_kirb():
	king.killed_kirby()
	endtimer.wait_time = 4
	explosion.play("explotion")
	_game_end()


func _on_display_timer_timeout():

	endtimer.start()
	match egg_count:
		0:
			background_music.stop()
			background_music.stream=no_bonus
			background_music.play()
			king.celebrate()
			shaderAnimator.play("end_game")
		30:
			background_music.stop()
			background_music.stream=perfect_bonus
			background_music.play()
			king.cry()
			kirby.vomit()
		_:
			background_music.stop()
			background_music.stream=bonus
			background_music.play()
			king.cry()
			kirby.vomit()
			shaderAnimator.play("end_game")
	board.display_score(egg_count)


func _on_endtimer_timeout():
	if king == null:
		return
	match egg_count:
		25,26:
			__up.play()
		27,28,29:
			__up.play()
			await __up.finished
			__up.play()
		30:
			__up.play()
			await __up.finished
			__up.play()
			await __up.finished
			__up.play()
	BackgroundAnimator.play("fade_out")


func _on_background_animator_animation_finished(anim_name):
	if anim_name == "fade_out":
		restart()


func _on_game_play_timer_timeout():
	lamps.visible = false
