extends Sprite2D
@export var egg:PackedScene
@export var bomb:PackedScene
@onready var spawn_timer = $spawn_timer
@onready var king_animator = $king_animator
@onready var ending_timer = $ending_timer
@onready var throw_sound = $throw_sound

var intro: bool = true
var eggs_count: int = 0
var done_throwing: bool = false
var kk: bool = false
signal done
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()  # This seeds the random number generator
	king_animator.play("Spotlight")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if intro or done_throwing:
		return
	check_done()


func spawn_random():
	random_throw_animation()
	throw_sound.play()
	if randf() < 0.7:
		spawn_egg()
	else:
		spawn_bomb()

func spawn_egg():
	
	eggs_count+=1
	var egg_spawn = egg.instantiate()
	add_child(egg_spawn)

func spawn_bomb():
	var bomb_spawn = bomb.instantiate()
	add_child(bomb_spawn)

func _on_game_play_timer():
	intro = false
	set_random_timer_interval()
	spawn_timer.start()

# This function sets a random time interval for the timer
func set_random_timer_interval():
	spawn_timer.wait_time = randf_range(0.36, 0.75)


func _on_spawn_timer_timeout():
	if done_throwing:
		return #when done throwing  stop the timers
	set_random_timer_interval()
	spawn_random()

func random_throw_animation():
	if randf() < 0.5:
		king_animator.play("throw")
	else:
		king_animator.play("short_throw")
func random_idle_animation():
	if randf() < 0.5:
		king_animator.play("angry")
	else:
		king_animator.play("faint")


func _on_king_animator_animation_finished(anim_name):
	if intro and done_throwing: #fix this
		return
	if anim_name == "throw" or anim_name == "short_throw":
			random_idle_animation()
		

func check_done():
	if eggs_count == 30:
		done_throwing = true
		
		king_animator.play("waiting_last_egg")
		ending_timer.start()


func _on_ending_timer_timeout():
	done.emit()

func celebrate():
		king_animator.play("celebrate")
		
func cry():
	if kk:
		celebrate()
		return
	king_animator.play("cry")

func killed_kirby():
	done_throwing = true
	kk = true
	king_animator.play("waiting_last_egg")
