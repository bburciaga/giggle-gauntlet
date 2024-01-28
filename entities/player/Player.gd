extends CharacterBody2D

enum WeaponState {
	INACTIVE,
	GNOME
}

@onready var anim = get_node("AnimatedSprite2D")
@onready var gnomeWeapon = get_node("GnomeWeapon")
const water_path = preload("res://entities/projectiles/Water.tscn")
const banana_path = preload("res://entities/projectiles/Banana.tscn")

var SPEED = 300
var INITIAL_WEAPON_POSITION = Vector2(915, -5)
var enemy
var weaponState = WeaponState.INACTIVE
var health = 6
var bananaCooldown: float = 1.0
var canDropBanana: bool = true

func _ready() -> void:
	gnomeWeapon.position = INITIAL_WEAPON_POSITION
	
func _physics_process(delta):
	var direction = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)
	move(direction)
	melee(direction)
	shoot()

func _on_gnome_hit_area_entered(area):
	if (area.is_in_group("Enemies")):
		area.take_damage()
	
# Input Functions
	
func move(direction):
	velocity = direction * SPEED
	
	if direction.length() > 0:
		anim.play("Run")
		anim.flip_h = direction.x < 0
	else:
		anim.play("Idle")
	move_and_slide()

func melee (direction):
	if Input.is_action_pressed("ui_accept"):
		if canDropBanana:
			drop_banana()
			start_cooldown()
		#if (weaponState == WeaponState.GNOME):
			#if(direction.x < 0):
				#gnomeWeapon.rotation_degrees = -45.0
				#gnomeWeapon.position = Vector2(-15, -5)
			#else:
				#gnomeWeapon.rotation_degrees = 45.0
				#gnomeWeapon.position = Vector2(15, -5)
			#gnomeWeapon.visible = true
	else:
		gnomeWeapon.position = INITIAL_WEAPON_POSITION
		gnomeWeapon.visible = true
	
func shoot():
	if Input.is_action_just_pressed("arrow_right"):
		var instance = water_path.instantiate()
		instance.transform = $CollisionShape2D.global_transform
		instance.rotation = 0
		owner.add_child(instance)
	
	if Input.is_action_just_pressed("arrow_left"):
		var instance = water_path.instantiate()
		instance.transform = $CollisionShape2D.global_transform
		instance.rotation_degrees = 180.0
		owner.add_child(instance)
		
	if Input.is_action_just_pressed("arrow_up"):
		var instance = water_path.instantiate()
		instance.transform = $CollisionShape2D.global_transform
		instance.rotation_degrees = 270.0
		owner.add_child(instance)
		
	if Input.is_action_just_pressed("arrow_down"):
		var instance = water_path.instantiate()
		instance.transform = $CollisionShape2D.global_transform
		instance.rotation_degrees = 90.0
		owner.add_child(instance)

func drop_banana():
	var banana_instance = banana_path.instantiate()
	banana_instance.position = position
	get_parent().add_child(banana_instance)

func start_cooldown():
	canDropBanana = false
	$CooldownTimer.start()

func _on_cooldown_timer_timeout():
	canDropBanana = true
	
# Activation Functions

func activate_gnome_weapon():
	weaponState = WeaponState.GNOME
	gnomeWeapon.visible = true
