extends CharacterBody2D

enum WeaponState {
	INACTIVE,
  	WATERGUN,
	GNOME,
	BANANA
}

@onready var anim: Node = get_node("AnimatedSprite2D")
@onready var gnomeWeapon: Node = get_node("GnomeWeapon")
@onready var watergunWeapon: Node = get_node("WaterGunWeapon")
const water_path: Resource = preload("res://entities/projectiles/Water.tscn")
const banana_path: Resource = preload("res://entities/projectiles/Banana.tscn")

var SPEED: float = 150.0
var INITIAL_WEAPON_POSITION: Vector2 = Vector2(915, -5)
var weaponState: WeaponState = WeaponState.WATERGUN
var health: int = 6
var canDropBanana: bool = true
var canShootWaterGun: bool = true

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
	if canShootWaterGun: shoot()
	game_over()
	
###### Input Functions ######

func take_damage(damage: int) -> void:
	health -= damage

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
		match weaponState:
			WeaponState.GNOME:
				if(direction.x < 0):
					gnomeWeapon.rotation_degrees = -45.0
					gnomeWeapon.position = Vector2(-19, -10)
				else:
					gnomeWeapon.rotation_degrees = 45.0
					gnomeWeapon.position = Vector2(19, -10)
				gnomeWeapon.visible = true
			WeaponState.BANANA:
				if canDropBanana:
					drop_banana()
					start_cooldown()
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

func drop_banana():
	var banana_instance = banana_path.instantiate()
	banana_instance.position = position
	get_parent().add_child(banana_instance)

##### Timeouts #####

func _on_cooldown_timer_timeout() -> void:
	canDropBanana = true

func _on_projectile_timer_timeout() -> void:
	canShootWaterGun = true

###### Activation Functions ######

func activate_gnome_weapon() -> void:
	weaponState = WeaponState.GNOME
	gnomeWeapon.visible = true
	
func activate_water_gun_weapon() -> void:
	weaponState = WeaponState.WATERGUN
	# visible true

func activate_banana_weapon() -> void:
	weaponState = WeaponState.BANANA
	# visible true

###### Helpers ######

func start_cooldown():
	match (weaponState):
		WeaponState.BANANA:
			canDropBanana = false
			$CooldownTimer.start()
		WeaponState.WATERGUN:
			canShootWaterGun = false
			$ProjectileTimer.start()

func start_projectile_cooldown():
	canShootWaterGun = false
	$ProjectileTime.start()

func add_projectile(degree: float) -> void:
	var instance: Water = water_path.instantiate()
	instance.transform = $CollisionShape2D.global_transform
	instance.rotation_degrees = degree
	owner.add_child(instance)
	start_cooldown()

func game_over():
	if health <= 0:
		get_tree().change_scene_to_file("res://menus/finish/Finish.tscn")

func _on_gnome_hit_area_entered(area) -> void:
	if (area.is_in_group("Enemies")):
		area.take_damage()
