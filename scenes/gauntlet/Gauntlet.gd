extends Node2D
class_name Globals

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

var adjusted_width = 100.0
var adjusted_height = 100.0

func _process(delta):
	$UI/Gnome.visible = false
	$UI/Watergun.visible = false
	$UI/Banana.visible = false
	match $Player.weaponState:
		Globals.WeaponState.GNOME:
			$UI/Gnome.visible = true
		Globals.WeaponState.WATERGUN:
			$UI/Watergun.visible = true
		Globals.WeaponState.BANANA:
			$UI/Banana.visible = true
			$UI/Banana.play("Default")
		
	match $Player.health:
		1:
			$UI/Health.play("1")
		2:
			$UI/Health.play("2")
		3:
			$UI/Health.play("3")
		4:
			$UI/Health.play("4")
		5:
			$UI/Health.play("5")
		6:
			$UI/Health.play("6")


#func _on_ready():		
	#$Enemy.add_to_group("Enemies")
	#$Enemy2.add_to_group("Enemies")
	
