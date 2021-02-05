extends Node

signal mute_enable
signal mute_disable

var muted = false
onready var master_bus = AudioServer.get_bus_index("Master")

onready var value_holder = []
onready var slider_value = []
onready var menu_music = load("res://assets/Audio/Music/MainMenu - DFS Haunted (loop).wav")
onready var level1_music = load("res://assets/Audio/Music/Level 1 - DFS Fear (loop).wav")


#func _process(delta):
#	print(str(value_holder))
#	var bus_value = AudioServer.get_bus_volume_db(master_bus)
#	print("Current volume: " + str(bus_value))
##	if value_holder.size() > 0:
##		value_holder.clear()
##		if value_holder.has(bus_value):
##			pass
##		else:
##			value_holder.append(bus_value)
##	else:
##		pass


func play_music(track):
	muted = false
	
	if not muted:
		
		if track == "Menu":
			$Music.stream = menu_music
			$Music.play()
		
		if track == "Level1":
			$Music.stream = level1_music
			$Music.play()
		pass
	else:
		pass

func stop():
	$Music.stop()

func resume():
	muted = false
	AudioServer.set_bus_volume_db(master_bus, linear2db(value_holder[-1]))
	emit_signal("mute_disable")

func mute():
	muted = true
	AudioServer.set_bus_volume_db(master_bus, -80)
	emit_signal("mute_enable")

func is_playing():
	if $Music.playing:
		return true
	else:
		return false

func is_muted():
	if muted == true:
		return true
	else:
		return false
