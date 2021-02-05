extends CanvasLayer

onready var timer = $SceneDuration

func _ready():
	timer.wait_time = 5
	timer.start()


func _on_SceneDuration_timeout():
	get_tree().change_scene("res://scenes/levels/Level1.tscn")
