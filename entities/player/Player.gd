extends CharacterBody2D

enum WeaponState {
	INACTIVE,
  WATERGUN,
	GNOME
}

@onready var anim: Node = get_node("AnimatedSprite2D")
@onready var gnomeWeapon: Node = get_node("GnomeWeapon")
@onready var watergunWeapon: Node = get_node("WaterGunWeapon")
const water_path: Resource = preload("res://entities/projectiles/Water.tscn")

var SPEED = 300
var INITIAL_WEAPON_POSITION = Vector2(915, -5)
var enemy
var weaponState: WeaponState = WeaponState.INACTIVE
var health = 6

func _ready() -> void:
	gnomeWeapon.position = INITIAL_WEAPON_POSITION
	
func _physics_process(delta) -> void:
	var direction = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)
	move(direction)
	melee(direction)
	shoot()

func _on_gnome_hit_area_entered(area) -> void:
	if (area.is_in_group("Enemies")):
		area.take_damage()
	
###### Input Functions ######

func move(direction) -> void:
	velocity = direction * SPEED
	
	if direction.length() > 0:
		anim.play("Run")
		anim.flip_h = direction.x < 0
	else:
		anim.play("Idle")
	move_and_slide()

func melee (direction):
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
	
func shoot() -> void:
	if WeaponState.WATERGUN == weaponState:
		if Input.is_action_just_pressed("arrow_right"):
			add_projectile(0.0)
		if Input.is_action_just_pressed("arrow_left"):
			add_projectile(180.0)
		if Input.is_action_just_pressed("arrow_up"):
			add_projectile(270.0)
		if Input.is_action_just_pressed("arrow_down"):
			add_projectile(90.0)

###### Activation Functions ######

func activate_gnome_weapon() -> void:
	weaponState = WeaponState.GNOME
	gnomeWeapon.visible = true
	
func activate_water_gun_weapon() -> void:
	weaponState = WeaponState.WATERGUN
	# visible true

###### Helpers ######
func add_projectile(degree: float) -> void:
	var instance: Water = water_path.instantiate()
	instance.transform = $CollisionShape2D.global_transform
	instance.rotation_degrees = degree
	owner.add_child(instance)
