extends CharacterBody2D

enum WeaponState {
	INACTIVE,
	GNOME
}

@onready var anim = get_node("AnimatedSprite2D")
@onready var gnomeWeapon = get_node("GnomeWeapon")

var SPEED = 300
var enemy
var weaponState = WeaponState.INACTIVE

func _physics_process(delta):
	enemy = get_node("../Necromancer")
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

func _on_gnome_hit_area_entered(area):
	enemy.take_damage()
	
func activate_gnome_weapon():
	weaponState = WeaponState.GNOME
	gnomeWeapon.visible = true
