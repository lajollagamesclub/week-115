extends KinematicBody2D

class_name Player

signal bonked

const ages = ["young", "adult", "old"]
const dampening = 10.0
const move_accel = 1500 
const jump_velocity = 800

export var gravity: float = 1200

var horizontal: int = 0
var vertical: int = 0

var accel: Vector2 = Vector2()
var vel: Vector2 = Vector2()
var jumping: bool = false
var age: int = 0 setget set_age
var cur_player_data: String = "YoungPlayer"

var floor_raycast: RayCast2D = null
var right_raycast: RayCast2D = null
var left_raycast: RayCast2D = null
var sprite: Sprite = null
var player_data: PlayerData = null

func update_playerdata():
	player_data = get_node(cur_player_data)
	sprite = player_data.get_node("Sprite")
	floor_raycast = player_data.get_node("FloorRayCast")
	right_raycast = player_data.get_node("RightRayCast")
	left_raycast = player_data.get_node("LeftRayCast")

func _ready():
	update_playerdata()

func _physics_process(delta):
	horizontal = int(Input.is_action_pressed("g_right")) - int(Input.is_action_pressed("g_left"))
	vertical = int(Input.is_action_pressed("g_down")) - int(Input.is_action_pressed("g_up"))
	
	if vertical < 0 and floor_raycast.is_colliding():
		jump()
	
	if vel.y < 0:
		set_casts_bit(1, false)
		set_collision_layer_bit(1, false)
		set_collision_mask_bit(1, false)
	else:
		set_casts_bit(1, true)
		set_collision_layer_bit(1, true)
		set_collision_mask_bit(1, true)
	
	if left_raycast.is_colliding() or right_raycast.is_colliding():
		if abs(vel.x) > 600:
			$BonkPlayer.play()
			emit_signal("bonked")
		vel.x *= -0.4
	
	if horizontal < 0:
		sprite.flip_h = true
	elif horizontal > 0:
		sprite.flip_h = false
	
	accel = Vector2(horizontal*move_accel, gravity)
	vel += accel*delta
	
	if floor_raycast.is_colliding():
		if not jumping:
			vel.y = 0.0
	else:
		jumping = false
	
	vel.x = dampen_value(vel.x, dampening)
	
	move_and_slide(vel)

func jump():
	jumping = true
	vel.y = -jump_velocity

func dampen_vector(in_vect: Vector2, amount: float) -> Vector2:
	var to_return: Vector2
	to_return.x = dampen_value(in_vect.x, amount)
	to_return.y = dampen_value(in_vect.y, amount)
	return to_return

func dampen_value(in_value: float, amount: float) -> float:
	if abs(in_value) < amount or in_value == amount:
		return 0.0
	return in_value - amount*sign(in_value)

func set_age(new_age: int):
	if new_age > ages.size():
		print("game over!")
	age = new_age
	var new_node: Player = null
	match ages[age]:
		"young":
			new_node = load("res://YoungPlayer.tscn").instance()
	replace_by(new_node, true)

func set_casts_bit(in_bit: int, value: bool):
	floor_raycast.set_collision_mask_bit(in_bit, value)
	right_raycast.set_collision_mask_bit(in_bit, value)
	left_raycast.set_collision_mask_bit(in_bit, value)