extends Sprite2D

var star = preload("res://little_star.tscn")

@onready var path_follow_2d = $".."
@onready var kirby_intro_animator = $KirbyIntroAnimator
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var pio = $Chicken/pio
@onready var explotion = $explotion
@onready var bounce_sound = $bounce_sound

signal bounced
signal egg_eated
signal gg

var anim
var bounce: bool = true
var get_up: bool = true
var eating: bool = false
var intro: bool = true
var _speed = 100
var egg_count: int = 0
var game_over: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	kirby_intro_animator.play("falling")
	
func _process(_delta):
	if intro or game_over:
		return
	if Input.is_action_pressed("eat") and not eating:
		eating = true;
		eat()
	if Input.is_action_just_released("eat") and eating:
		kirby_intro_animator.play("idle")
		eating = false;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	check_bounce()	
	
	if(get_up && path_follow_2d.get_progress()>=141):
		get_up = false;

		kirby_intro_animator.play("get_up")	
	path_follow_2d.set_progress(path_follow_2d.get_progress() + _speed * delta)
	
	
func check_bounce():
	if(bounce && path_follow_2d.get_progress()>=115):
		_speed=50
		kirby_intro_animator.play("bounce")
		bounce=false
		var instance = star.instantiate()
		add_child(instance)
		bounced.emit()


func _on_game_play_timer():
	intro = false
	kirby_intro_animator.play("idle")


func _on_area_2d_body_entered(body):
	bounce_sound.play()
	if game_over:
		return
	if(not eating):
		kirby_intro_animator.play("head_bounce")
		
	else:
		if body is Egg:
			audio_stream_player_2d.play()
			egg_count+=1
			kirby_intro_animator.play("gulp")
			egg_eated.emit(egg_count)
		elif body is Bomb:
			game_over = true
			kirby_intro_animator.play("explotion")
			explotion.play()
			gg.emit()

		body.queue_free()
		

func  eat():
	kirby_intro_animator.play("ready_eat")
	
func vomit():
	if game_over:
		return
	game_over = true
	for i in range(egg_count):
		pio.play()
		kirby_intro_animator.play("vomit")  # Assuming your AnimationPlayer has an animation named "vomit_chick"
		await kirby_intro_animator.animation_finished # Wait until the animation completes
	egg_count = 0  # Reset egg_count after animation
	kirby_intro_animator.play("finish")
