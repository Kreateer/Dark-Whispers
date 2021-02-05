extends Popup

onready var actions = InputMap.get_actions()
var joy = Globals.joystart
var esc = Globals.esckey

func _ready():
	# Add popup that asks Player to use
	# keyboard or gamepad
	
	
	if Globals.return_input_type() == "Gamepad":
		Input.parse_input_event(joy)
		$Resume.shortcut.set_shortcut(joy)
		$Resume.button_mask = 0
		$Exit.button_mask = 0
	else:
		Input.parse_input_event(esc)
		$Resume.shortcut.set_shortcut(esc)
	pass



func _on_Resume_pressed():
	if get_tree().paused == true:
		get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	get_parent().get_node("Pause").disabled = false
	get_tree().call_group("PauseButtons", "release_focus")
	self.hide()


func _on_Exit_pressed():
	get_tree().quit()


func _on_Options_pressed():
	get_tree().call_group("PauseButtons", "release_focus")
	get_tree().call_group("PauseButtons", "hide")
	get_tree().call_group("PauseVolume", "show")
	get_tree().call_group("PauseVolume", "grab_focus")
