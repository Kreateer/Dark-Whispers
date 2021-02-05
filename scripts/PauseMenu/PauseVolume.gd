extends HSlider

export var audio_bus_name = "Master"

onready var bus = AudioServer.get_bus_index(audio_bus_name)
onready var audio = AudioController


func _ready() -> void:
	value = db2linear(AudioServer.get_bus_volume_db(bus))
	print(str(AudioController.slider_value))
	self.value = AudioController.slider_value[-1]

#func _process(delta):
#	if self.visible:
#		get_tree().call_group("VolumeMenu", "grab_focus")
#	else:
#		pass
#	pass

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus, linear2db(value))


func _on_VolumeSlider_value_changed(value):
	if not AudioController.is_muted():
		AudioController.value_holder.append(value)
		_on_value_changed(value)
	else:
		pass


func _on_Back_pressed():
	self.release_focus()
	self.hide()
	get_tree().call_group("PauseButtons", "show")
	get_tree().call_group("PauseButtons", "grab_focus")


func _on_Mute_toggled(button_pressed):
	if button_pressed:
		if audio.is_playing():
			audio.mute()
		$Mute.pressed = true
		self.scrollable = false
		self.editable = false
		
	else:
		audio.resume()
		$Mute.pressed = false
		self.scrollable = true
		self.editable = true
