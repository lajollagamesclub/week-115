extends Node2D

class_name PlayerData

var shape_owner: int = -1

func _ready():
	shape_owner = get_parent().create_shape_owner(get_parent())
	get_parent().shape_owner_add_shape(shape_owner, $CollisionShape2D.shape)
	$FloorRayCast.add_exception(get_parent())
	$RightRayCast.add_exception(get_parent())
	$LeftRayCast.add_exception(get_parent())

func _on_PlayerData_tree_exiting():
	get_parent().shape_owner_clear_shapes(shape_owner)