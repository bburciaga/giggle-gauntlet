extends CharacterBody2D

enum WeaponState {
	INACTIVE,
	GNOME
}

@onready var anim = get_node("AnimatedSprite2D")
@onready var gnomeWeapon = get_node("GnomeWeapon")

var SPEED = 300
var INITIAL_WEAPON_POSITION = Vector2(915, -5)
var enemy
var weaponState = WeaponState.INACTIVE
var health = 6

func _ready():
	gnomeWeapon.position = INITIAL_WEAPON_POSITION
	
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
			if(direction.x < 0):
				gnomeWeapon.rotation_degrees = -45.0
				gnomeWeapon.position = Vector2(-15, -5)
			else:
				gnomeWeapon.rotation_degrees = 45.0
				gnomeWeapon.position = Vector2(15, -5)
			gnomeWeapon.visible = true
	else:
		gnomeWeapon.position = INITIAL_WEAPON_POSITION
		gnomeWeapon.visible = true

func _on_gnome_hit_area_entered(area):
	if area.is_in_group("Enemies"):
		area.take_damage()
	
func activate_gnome_weapon():
	weaponState = WeaponState.GNOME
	gnomeWeapon.visible = true
