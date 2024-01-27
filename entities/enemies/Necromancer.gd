extends CharacterBody2D

@onready var anim = get_node("AnimatedSprite2D")

var player
var SPEED = 150
var chase = false

func _physics_process(delta):
	player = get_node("../Player")
	var direction = (player.global_position - self.global_position).normalized()
	
	if chase == true:
		velocity = direction * SPEED
		
		if direction.length() > 0:
			if anim.animation != "Death":
				anim.play("Run")
			anim.flip_h = direction.x < 0
		else:

			anim.play("Idle")
	else:
		anim.play("Idle")
	move_and_slide()
	
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		#player = body
		chase = true;


func _on_enemy_death_body_entered(body):
	if body.name == "Player":
		anim.play("Death")
		await anim.animation_finished
		self.queue_free()
