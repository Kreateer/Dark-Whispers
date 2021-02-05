extends CanvasLayer

signal is_visible

func _process(delta):
	if $HandsPopup.visible:
		emit_signal("is_visible")

func play_animation():
	$HandsPopup/DeathHandsLeft/LeftAnim.play("HandsFadeIn")
	$HandsPopup/DeathHandsRight/RightAnim.play("HandsFadeIn")
