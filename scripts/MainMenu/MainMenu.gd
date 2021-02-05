extends CanvasLayer

func _ready():
	AudioController.play_music("Menu")
	if Input.get_connected_joypads().size() > 0:
		print(Input.get_connected_joypads())
		$GamepadPopup.show()
		get_tree().call_group("GamepadPopupButtons", "grab_focus")
	else:
		pass
	get_tree().call_group("MenuButtons", "grab_focus")
	
	$CanvasLayer/Fire.play("default")
	$CanvasLayer/Fire/FireLight/FireAnimation.play("Flicker")
	$CanvasLayer/Light2D/TorchAnimation.play("TorchFlicker")

func _on_Yes_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$MenuControl/Start.button_mask = 0
	$MenuControl/Exit.button_mask = 0
	Globals.add_input_type("Gamepad")
	get_tree().call_group("GamepadPopupButtons", "release_focus")
	$GamepadPopup.hide()
	get_tree().call_group("MenuButtons", "grab_focus")


func _on_No_pressed():
	Globals.add_input_type("Keyboard")
	get_tree().call_group("GamepadPopupButtons", "release_focus")
	$GamepadPopup.hide()
	get_tree().call_group("MenuButtons", "grab_focus")
	pass


func _on_Start_pressed():
	#get_tree().change_scene("res://scenes/levels/Level1.tscn")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	AudioController.stop()
	get_tree().change_scene("res://scenes/LoadingScreen.tscn")


func _on_Exit_pressed():
	get_tree().quit()


func _on_Options_pressed():
	# Show Options Menu
	get_tree().call_group("MenuButtons", "release_focus")
	get_tree().call_group("MenuButtons", "hide")
	get_tree().call_group("OptionsMenu", "show")
	get_tree().call_group("OptionsMenu", "grab_focus")


#func _on_Mute_pressed():
#	# Mute Music
#	if $AudioStreamPlayer.playing:
#		$AudioStreamPlayer.stop()
#		#$AudioStreamPlayer.stream_paused = true
#	else:
#		$AudioStreamPlayer.play()


func _on_Controls_pressed():
	# Show gamepad controls
	get_tree().call_group("OptionsMenu", "release_focus")
	get_tree().call_group("OptionsMenu", "hide")
	#get_tree().call_group("MenuButtons", "hide")
	$MenuControl/GameTitle.hide()
	$MenuControl/GamepadControls.show()
	$MenuControl/ControlBack.show()
	$MenuControl/ControlBack.grab_focus()


func _on_Back_pressed():
	get_tree().call_group("OptionsMenu", "release_focus")
	get_tree().call_group("OptionsMenu", "hide")
	get_tree().call_group("MenuButtons", "show")
	get_tree().call_group("MenuButtons", "grab_focus")


func _on_Audio_pressed():
	get_tree().call_group("OptionsMenu", "release_focus")
	get_tree().call_group("OptionsMenu", "hide")
	$MenuControl/VolumeSlider.show()
	$MenuControl/VolumeSlider.grab_focus()


func _on_ControlBack_pressed():
	$MenuControl/ControlBack.release_focus()
	$MenuControl/ControlBack.hide()
	$MenuControl/GamepadControls.hide()
	$MenuControl/GameTitle.show()
	get_tree().call_group("OptionsMenu", "show")
	get_tree().call_group("OptionsMenu", "grab_focus")
