extends Area2D

signal bounce

class_name PlayerData

const game_state = preload("res://game_state.tres")

var area_groups = {
	"gasoline": [],
	"hair_spray": [],
	"fire": [],
	"bouncy": [],
	"big_bouncy": [],
	"instadeath": [],
	"chokey": []
}

var shape_owner: int = -1

func _ready():
	shape_owner = get_parent().create_shape_owner(get_parent())
	get_parent().shape_owner_add_shape(shape_owner, $CollisionShape2D.shape)
	$FloorRayCast.add_exception(get_parent())
	$RightRayCast.add_exception(get_parent())
	$LeftRayCast.add_exception(get_parent())

func _on_PlayerData_tree_exiting():
	get_parent().shape_owner_clear_shapes(shape_owner)

func calculate_next_event():
	if area_groups["bouncy"].size() > 0:
		game_state.emit_event("bounce", get_parent().vel.y)
	elif area_groups["big_bouncy"].size() > 0:
		game_state.emit_event("big_bounce", get_parent().vel.y)

func _on_PlayerData_area_entered(area):
	for g in area_groups:
		if area.is_in_group(g):
			area_groups[g].append(area)
	calculate_next_event() # from areas inside

func _on_PlayerData_area_exited(area):
	for g in area_groups:
		if area.is_in_group(g):
			area_groups[g].erase(area)