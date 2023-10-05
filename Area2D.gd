extends Area2D



func _on_body_exited(body):

	if body is RigidBody2D:  # Adjust this condition based on the type of object you want to destroy

		body.queue_free()

