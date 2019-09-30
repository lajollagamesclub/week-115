extends Area2D

signal bounce

class_name PlayerData

var area_groups = {
	"gasoline": [],
	"hair_spray": [],
	"fire": [],
	"bouncy": [],
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
		area_groups["bouncy"].clear()
		emit_signal("bounce")

func _on_PlayerData_area_entered(area):
	for g in area_groups:
		if area.is_in_group(g):
			area_groups[g].append(area)
	calculate_next_event() # from areas inside

func _on_PlayerData_area_exited(area):
	for g in area_groups:
		if area.is_in_group(g):
			area_groups[g].erase(area)