extends KinematicBody2D

const dampening = 10.0
const move_accel = 1300 
const jump_velocity = 500

export var gravity: float = 800

var horizontal: int = 0
var vertical: int = 0

var accel: Vector2 = Vector2()
var vel: Vector2 = Vector2()
var jumping: bool = false

func _physics_process(delta):
	horizontal = int(Input.is_action_pressed("g_right")) - int(Input.is_action_pressed("g_left"))
	vertical = int(Input.is_action_pressed("g_down")) - int(Input.is_action_pressed("g_up"))
	if vertical < 0 and $FloorRayCast.is_colliding():
		print("jumping")
		jump()
	accel = Vector2(horizontal*move_accel, gravity)
	vel += accel*delta
	if $FloorRayCast.is_colliding():
		if not jumping:
			vel.y = 0.0
	else:
		jumping = false
	vel.x = dampen_value(vel.x, dampening)
	move_and_collide(vel*delta)

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