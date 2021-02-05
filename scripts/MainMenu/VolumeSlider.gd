extends HSlider


export var audio_bus_name = "Master"

onready var bus = AudioServer.get_bus_index(audio_bus_name)
onready var audio = AudioController


func _ready() -> void:
	value = db2linear(AudioServer.get_bus_volume_db(bus))

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
		AudioController.slider_value.append(self.value)
		_on_value_changed(value)
	else:
		pass


func _on_VolumeBack_pressed():
	get_tree().call_group("VolumeMenu", "release_focus")
	get_tree().call_group("VolumeMenu", "hide")
	get_tree().call_group("OptionsMenu", "show")
	get_tree().call_group("OptionsMenu", "grab_focus")


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
