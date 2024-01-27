extends CharacterBody2D

@onready var anim = get_node("AnimatedSprite2D")

func _physics_process(delta):
	var direction = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)
	velocity = direction * 300
	
	if direction.length() > 0:
		anim.play("Run")
	else:
		anim.play("Idle")
		
	move_and_slide()
