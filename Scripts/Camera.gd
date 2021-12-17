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

extends Camera2D

const ZOOM_SPEED = 20
const ZOOM_STEP = 0.03
const FACTOR_STEP = 0.01

onready var _zoomFactor = 1

func _process(delta: float) -> void:
	"""On process."""

	zoom.x = lerp(zoom.x, _zoomFactor * zoom.x, ZOOM_SPEED * delta)
	zoom.y = lerp(zoom.y, _zoomFactor * zoom.y, ZOOM_SPEED * delta)

	zoom.x = clamp(zoom.x, 0.5, 2)
	zoom.y = clamp(zoom.y, 0.5, 2)

	if _zoomFactor > 1:
		_zoomFactor -= FACTOR_STEP
	elif _zoomFactor < 1:
		_zoomFactor += FACTOR_STEP

func _input(event: InputEvent) -> void:
	"""On input evemnts."""
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			_zoomFactor -= ZOOM_STEP
		elif event.button_index == BUTTON_WHEEL_DOWN:
			_zoomFactor += ZOOM_STEP
