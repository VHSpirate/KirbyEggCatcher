extends RigidBody2D

var GRAVITY = 980

func _ready():
	pass

func random_launch():
	var x_distance = 95
	var y_distance = 35
	
	var random_angle = deg_to_rad(randf() * (251 - 180) + 180)  # Random angle between 180 and 251 degrees
	print("Random Angle (degrees):", rad_to_deg(random_angle))
	
	var v = calculate_initial_velocity(x_distance, y_distance, random_angle)
	print("Calculated Initial Velocity:", v)
	
	var impulse = Vector2(v * cos(random_angle), v * sin(random_angle))
	print("Impulse:", impulse)
	
	self.linear_velocity = impulse


func calculate_initial_velocity(x, y, angle):
	var numerator = GRAVITY * x * x
	var denominator = 2 * (y + x * tan(angle)) * cos(angle) * cos(angle)
	
	if denominator <= 0:  # Check to ensure we don't get a negative or zero value in the denominator
		return 0
	
	return sqrt(numerator / denominator)

# You can still include the _process function if you want to check for other conditions or behaviors
func _process(delta):
	pass
