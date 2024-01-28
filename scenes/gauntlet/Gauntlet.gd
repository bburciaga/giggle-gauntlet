extends Node2D

func _draw():
	draw_rect(Rect2(0.0, 0.0, 1167.0, 16.0), Color.BLACK)
	draw_rect(Rect2(0.0, 650.0, 1167.0, 16.0), Color.BLACK)
	draw_rect(Rect2(0.0, 0.0, 16.0, 650.0), Color.BLACK)
	draw_rect(Rect2(1156.0, 0.0, 16.0, 650.0), Color.BLACK)

func _process(delta):
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
