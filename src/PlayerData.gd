extends Node2D

class_name PlayerData

func _ready():
	var shape_owner = get_parent().create_shape_owner(get_parent())
	get_parent().shape_owner_add_shape(shape_owner, $CollisionShape2D.shape)
	$FloorRayCast.add_exception(get_parent())
	$RightRayCast.add_exception(get_parent())
	$LeftRayCast.add_exception(get_parent())