extends StaticBody2D

func _ready():
	pass


func _physics_process(delta):
	if self.visible:
		set_process(true)
		$CampfireSprite.play("default")
		$FireLight/CampfireFlicker.play("Flicker")
	else:
		set_process(false)


func _on_LightDetect_body_entered(body):
	if body is KinematicBody2D:
		print("Yes yes yes")
		get_parent().get_node("Player").infinite_light(true)
		pass
	else:
		pass


func _on_LightDetect_body_exited(body):
	if body is KinematicBody2D:
		get_parent().get_node("Player").infinite_light(false)
		pass
	else:
		pass
