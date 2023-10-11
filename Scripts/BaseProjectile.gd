class_name BaseProjectile
extends RigidBody2D

# Fetch gravity value once when the script loads
var GRAVITY: float = ProjectSettings.get("physics/2d/default_gravity")

func _ready():
	pass

func random_launch():
	var x_distance = 95
	var y_distance = 35
	var random_angle = deg_to_rad(randf_range(180, 252))  # Random angle between 180 and 251 degrees
	var velocity_magnitude = calculate_initial_velocity(x_distance, y_distance, random_angle)
	var impulse = Vector2.RIGHT.rotated(random_angle) * velocity_magnitude  # Convert polar coordinates to Cartesian
	self.linear_velocity = impulse

func calculate_initial_velocity(x: float, y: float, angle: float) -> float:
	var numerator = GRAVITY * x * x
	var denominator = 2 * (y + x * tan(angle)) * pow(cos(angle), 2)
	
	if denominator <= 0:  # Check to ensure we don't get a negative or zero value in the denominator
		return 0
	
	return sqrt(numerator / denominator)
