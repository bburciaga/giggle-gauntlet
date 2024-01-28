extends CharacterBody2D

enum WeaponState {
	INACTIVE,
	GNOME
}

@onready var anim = get_node("AnimatedSprite2D")

var SPEED = 300

func _ready():
	gnomeWeapon.position = Vector2(915, -5)
	
func _physics_process(delta):
	var direction = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)
	velocity = direction * SPEED
	
	if direction.length() > 0:
		anim.play("Run")
		anim.flip_h = direction.x < 0
		
	else:
		anim.play("Idle")
		
	move_and_slide()
	
	if Input.is_action_pressed("ui_accept"):
		if (weaponState == WeaponState.GNOME):
			gnomeWeapon.position = Vector2(15, -5)
			gnomeWeapon.visible = true
	else:
		gnomeWeapon.visible = false

func _on_gnome_hit_area_entered(area):
	enemy.take_damage()
	
func activate_gnome_weapon():
	weaponState = WeaponState.GNOME
	gnomeWeapon.visible = true
