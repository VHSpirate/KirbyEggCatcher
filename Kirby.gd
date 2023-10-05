extends Sprite2D

var star = preload("res://little_star.tscn")

@onready var path_follow_2d = $".."
@onready var kirby_intro_animator = $KirbyIntroAnimator


signal bounced
signal egg_eated
var anim
var bounce: bool = true
var get_up: bool = true
var eating: bool = false
var intro: bool = true
var _speed = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	kirby_intro_animator.play("falling")

func _process(delta):
	if intro:
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
	
	
func check_bounce():	if(bounce && path_follow_2d.get_progress()>=115):
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
	if(not eating):
		kirby_intro_animator.play("head_bounce")
	else:
		body.queue_free()
		kirby_intro_animator.play("gulp")
		egg_eated.emit()



func  eat():
	kirby_intro_animator.play("ready_eat")
