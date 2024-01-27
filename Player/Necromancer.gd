extends CharacterBody2D

var player
var speed = 300
var chase = false

func _physics_process(delta):
	if chase == true:
		#print(player.global_position)
		var direction = (player.global_position - self.global_position).normalized()
		velocity = direction * speed
		print(velocity.x)
	move_and_slide()
	
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		player = body
		chase = true;
		print(player)
