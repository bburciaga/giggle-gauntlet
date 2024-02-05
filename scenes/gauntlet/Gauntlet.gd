extends Node2D

enum WeaponState {
	INACTIVE,
	WATERGUN,
	GNOME,
	BANANA
}

func _draw():
	draw_rect(Rect2(0.0, 0.0, 1167.0, 16.0), Color.BLACK)
	draw_rect(Rect2(0.0, 650.0, 1167.0, 16.0), Color.BLACK)
	draw_rect(Rect2(0.0, 0.0, 16.0, 650.0), Color.BLACK)
	draw_rect(Rect2(1156.0, 0.0, 16.0, 650.0), Color.BLACK)

func _process(delta):
	$UI/Gnome.visible = false
	$UI/Watergun.visible = false
	$UI/Banana.visible = false
	match $Player.weaponState:
		WeaponState.GNOME:
			$UI/Gnome.visible = true
		WeaponState.WATERGUN:
			$UI/Watergun.visible = true
		WeaponState.BANANA:
			$UI/Banana.visible = true
			$UI/Banana.play("Default")
				
	#match $Player.health:
		#1:
			#$UI/Health.play("1")
		#2:
			#$UI/Health.play("2")
		#3:
			#$UI/Health.play("3")
		#4:
			#$UI/Health.play("4")
		#5:
			#$UI/Health.play("5")
		#6:
			#$UI/Health.play("6")


#func _on_ready():		
	#$Enemy.add_to_group("Enemies")
	#$Enemy2.add_to_group("Enemies")
	
