extends Node2D

@export var spawns: Array[ItemInfo] = []

@onready var player: Node = get_tree().get_first_node_in_group("Player")

var time: int = 0

func _on_timer_timeout():
	time += 1

	var item_spawns = spawns
	for i in item_spawns:
		if i.time_start <= time and i.time_end >= time:
			if i.spawn_delay_counter < i.item_spawn_delay:
				i.spawn_delay_counter += 1
			else:
				i.spawn_delay_counter = 0
				var new_item = load(str(i.item.resource_path))
				var counter = 0
				while counter < i.item_num:
					var item_spawn = new_item.instantiate()
					item_spawn.global_position = get_random_position()
					owner.add_child(item_spawn)
					counter += 1

func get_random_position():
	var vpr = get_viewport_rect().size * randf_range(1.1, 1.4)
	var top_left: Vector2 = Vector2(
		player.global_position.x + vpr.x / 8,
		player.global_position.y + vpr.y / 8
	)
	var top_right: Vector2 = Vector2(
		player.global_position.x - vpr.x / 8,
		player.global_position.y + vpr.y / 8
	)
	var bottom_left: Vector2 = Vector2(
		player.global_position.x + vpr.x / 8,
		player.global_position.y - vpr.y / 8
	)
	var bottom_right: Vector2 = Vector2(
		player.global_position.x - vpr.x / 8,
		player.global_position.y - vpr.y / 8
	)
	
	var pos_side: String = ["up", "down", "left", "right"].pick_random()
	var spawn_pos1: Vector2 = Vector2.ZERO
	var spawn_pos2: Vector2 = Vector2.ZERO
	
	match pos_side:
		"up":
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		"down":
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"left":
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left
		"right":
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right
	
	var x_spawn: float = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn: float = randf_range(spawn_pos1.y, spawn_pos2.y)
	
	return Vector2(x_spawn, y_spawn)
