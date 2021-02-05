extends Button

onready var actions = InputMap.get_actions()
var joy = Globals.joystart
var esc = Globals.esckey

func _ready():
	# Add popup that asks Player to use
	# keyboard or gamepad
	
	
	if Globals.return_input_type() == "Gamepad":
		Input.parse_input_event(joy)
		self.shortcut.set_shortcut(joy)
		self.button_mask = 0
	else:
		Input.parse_input_event(esc)
		self.shortcut.set_shortcut(esc)
	pass

func _on_Pause_pressed():
	if get_tree().paused != true:
		get_tree().paused = true
	self.disabled = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_parent().get_node("PausePopup").show()
	get_tree().call_group("PauseButtons", "grab_focus")
