extends CharacterBody2D

@onready var anim = get_node("AnimatedSprite2D")

var player
var SPEED = 300
var chase = false

func _physics_process(delta):
	if chase == true:
		var direction = (player.global_position - self.global_position).normalized()
		velocity = direction * SPEED
		
		if direction.length() > 0:
			anim.play("Run")
			anim.flip_h = direction.x < 0
		else:
			anim.play("Idle")
	else:
		anim.play("Idle")
	move_and_slide()
	
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		player = get_node("../Player")
		#player = body
		chase = true;
