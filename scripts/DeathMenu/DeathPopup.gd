extends Popup

#func _process(delta):
#	if self.visible:
#		get_tree().call_group("DeathButtons", "get_focus")
#	else:
#		pass


func _on_Retry_pressed():
	if self.visible:
		get_tree().paused = false
		#get_parent().get_parent().get_parent().get_node("Player").reset()
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		get_tree().call_group("DeathButtons", "release_focus")
		get_tree().reload_current_scene()
		self.hide()
	# Reset Player and attributes


func _on_Exit_pressed():
	get_tree().quit()

func _on_DeathPopup_visibility_changed():
	if self.visible:
		get_tree().call_group("DeathButtons", "grab_focus")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		pass
