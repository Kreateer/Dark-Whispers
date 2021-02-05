extends Node

func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	AudioController.play_music("Level1")
	$Player/Fade/FadeOverlay.show()
	yield(get_tree().create_timer(1), "timeout")
	$Player/Fade/FadeOverlay/FadeAnimation.play("FadeIn")
	$Player.show()
