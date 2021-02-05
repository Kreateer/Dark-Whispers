# Constant values spanning the entire game
extends Node

"""
Global Constants
"""

## Cause of death for the player
const DARKNESS = "Darkness"
const HEALTH = "Health"
# Scene and level paths
const SCENE_PATH = "res://scenes/"
const LEVEL_PATH = "res://scenes/levels"

var joystart = InputEventAction.new()
var esckey = InputEventAction.new()
var input_type = []

func _ready():
	joystart.action = "JoyStart"
	esckey.action = "Escape"
	Input.connect("joy_connection_changed", self, "joy_con_changed")

func add_input_type(value):
	if value == "Gamepad":
		input_type.append("Gamepad")
	else:
		input_type.append("Keyboard")
	pass

func return_input_type():
	for input in input_type:
		return input

func joy_con_changed(deviceid, isConnected):
	if isConnected:
		print("Gamepad " + str(deviceid) + " connected")
		if Input.is_joy_known(0):
			print("Recognized and compatible gamepad")
			print(Input.get_joy_name(0) + " device connected")
	else:
		print("Gamepad " + str(deviceid) + " disconnected")
