class_name BaseProjectile
extends RigidBody2D

var GRAVITY = ProjectSettings.get("physics/2d/default_gravity")


func _ready():
	pass

func random_launch():
	var x_distance = 95
	var y_distance = 35
	var random_angle = deg_to_rad(randf() * (252 - 180) + 180)  # Random angle between 180 and 251 degrees
	var v = calculate_initial_velocity(x_distance, y_distance, random_angle)
	var impulse = Vector2(v * cos(random_angle), v * sin(random_angle))
	self.linear_velocity = impulse


func calculate_initial_velocity(x, y, angle):
	var numerator = GRAVITY * x * x
	var denominator = 2 * (y + x * tan(angle)) * cos(angle) * cos(angle)
	
	if denominator <= 0:  # Check to ensure we don't get a negative or zero value in the denominator
		return 0
	
	return sqrt(numerator / denominator)


