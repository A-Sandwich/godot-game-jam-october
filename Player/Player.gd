extends KinematicBody2D

var motion = Vector2(0, 0)
const UP = Vector2(0, -1)
const SPEED = 1500
const GRAVITY = 300
const JUMP_SPEED = 3000
const WORLD_LIMIT = 4000

var lives = 1

signal animate

func _physics_process(delta):
	apply_gravity()
	move()
	jump()
	animate()
	move_and_slide(motion, UP)

func animate():
	emit_signal("animate", motion)

func apply_gravity():
	if position.y > WORLD_LIMIT:
		end_game()
	elif is_on_floor():
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 1
	else:
		motion.y += GRAVITY

func move():
	var left_pressed = Input.is_action_pressed("Left")
	var right_pressed = Input.is_action_pressed("Right")
	
	if left_pressed && right_pressed:
		motion.x = 0
	elif left_pressed:
		motion.x = -SPEED
	elif right_pressed:
		motion.x = SPEED
	else:
		motion.x = 0

func jump():
	var jump_pressed = Input.is_action_pressed("Jump")
	if jump_pressed && is_on_floor():
		motion.y -= JUMP_SPEED

func end_game():
	print("Game ended")
	get_tree().change_scene("res://Levels/Level1.tscn")
