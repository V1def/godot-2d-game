# MIT License

# Copyright (c) 2021 V1def

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

extends KinematicBody2D

const SPEED = 200
const MAX_MOVE_SPEED = 200
const GRAVITY = 1500
const JUMP_FORCE = 600

var _velocity = Vector2()
onready var _player = get_node("Sprite")

func _physics_process(delta: float) -> void:
	"""On physics process."""
	# Handle movement inputs.
	_control()
	# Calculate gravity.
	_gravity(delta)

	# Set max player speed.
	_velocity.x = clamp(_velocity.x, -MAX_MOVE_SPEED, MAX_MOVE_SPEED)

	if _velocity.x < 0:
		_player.flip_h = true
	elif _velocity.x > 0:
		_player.flip_h = false

	_velocity = move_and_slide(_velocity, Vector2.UP, true)

func _control() -> void:
	"""Handle movement inputs."""
	if Input.is_action_pressed("right"):
		_velocity.x += SPEED
	elif Input.is_action_pressed("left"):
		_velocity.x -= SPEED
	else:
		if is_on_floor():
			_velocity.x = 0

	if Input.is_action_just_pressed("up") and is_on_floor():
		_velocity.y -= JUMP_FORCE

func _gravity(delta: float) -> void:
	"""Calculate gravity."""
	_velocity.y += GRAVITY * delta
