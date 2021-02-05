extends Character

var last_direction = Vector2(0, 1)
onready var max_light = 100
onready var light = max_light
onready var light_counter = $HUD/LightCounter
onready var camera_origin = Vector2()

func _ready():
	origin = self.transform.get_origin()
	camera_origin = $Camera2D.transform.get_origin()
	resetAttributes()
	$Light2D/TorchFlicker.play("Player_Torch_Flicker")
	$Light2D/LightDuration.wait_time = 1
	$Light2D/LightDuration.start()


func resetAttributes():	
	health = max_health
	movement_speed = 30
	light = max_light
	light_counter.text = str(light)
	alive = true
	$Light2D.energy = 1

func resetPosition():
	self.position = origin
	$Camera2D.position = camera_origin

func reset():
	$Light2D/LightDuration.stop()
	
	#get_tree().call_group("Hideables", "show")
	resetPosition()
	#yield(get_tree().create_timer(0.5), "timeout")
	resetAttributes()
	
	$Fade/FadeOverlay/FadeAnimation.play("FadeIn")
	#$FadeOverlay/FadeAnimation.play("FadeIn")
	#if not $Camera2D/FadeOverlay/FadeAnimation.is_playing():
	#	self.show()
	$Light2D/LightDuration.start()

# Main Player movement
func get_input():
	velocity.x = 0
	velocity.y = 0
	# Keyboard controls
	var key_right = Input.is_action_pressed("D")
	var key_left = Input.is_action_pressed("A")
	var key_up = Input.is_action_pressed("W")
	var key_down = Input.is_action_pressed("S")
	
	# Gamepad controls
	var joy_right = Input.is_action_pressed("JoyRight")
	var joy_left = Input.is_action_pressed("JoyLeft")
	var joy_up = Input.is_action_pressed("JoyUp")
	var joy_down = Input.is_action_pressed("JoyDown")
	
	if key_right or joy_right:
		velocity.x += movement_speed
	if key_left or joy_left:
		velocity.x -= movement_speed
	if key_up or joy_up:
		velocity.y -= movement_speed
	if key_down or joy_down:
		velocity.y += movement_speed
	
	
#	if rjp:
#		$PlayerSprite.play("IdleRight")
#	if ljp:
#		$PlayerSprite.play("IdleLeft")
#	if ujp:
#		$PlayerSprite.play("IdleUp")
#	if djp:
#		$PlayerSprite.play("IdleDown")
	
	
#	if not right && not left && not up && not down:
#		$PlayerSprite.play("IdleDown")

func get_animation_direction(direction: Vector2):
	var norm_direction = direction.normalized()
	if norm_direction.y >= 0.707:
		return "Down"
	elif norm_direction.y <= -0.707:
		return "Up"
	elif norm_direction.x <= -0.707:
		return "Left"
	elif norm_direction.x >= 0.707:
		return "Right"
	return "Down"

func animate_player(direction: Vector2):
	if direction != Vector2.ZERO:
		last_direction = direction
		
		var animation = get_animation_direction(last_direction) + "_Walk"
		
		$PlayerSprite.play(animation)
	else:
		var animation = get_animation_direction(last_direction) + "_Idle"
		$PlayerSprite.play(animation)
# Main player heal function
func player_heal(amount):
	if health != max_health:
		health += amount
		emit_signal("healed")
		print("Healed {0} points".format([amount]))
	else:
		pass

# Sets health value to specific amount
func set_health(amount):
	health = amount

# Checks and returns current player health value
func check_health():
	return health

func get_player_collision():
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		print("Collided with ", collision.collider.name)
		print("Line break...\n")

func process_mode(setter: bool):
	if setter == true:
		set_process(true)
	else:
		set_process(false)


func light_countdown():
	if light != 0:
		light -= 1
		light_counter.text = str(light)
		print(light)
		if light <= 10:
			$Light2D/LightAnimation.play("Fade")
	else:
		#$Light2D/LightAnimation.play("Fade")
		if not $Light2D/LightAnimation.is_playing():
			#yield(countdown_timer, "timeout")
			#Player Death
			_die(Globals.DARKNESS)
		#$Light2D/LightDuration.stop()
	pass

func infinite_light(enabled: bool):
	if enabled == true:
		$Light2D/LightDuration.stop()
		light = max_light
		light_counter.text = str(light)
	else:
		if $Light2D/LightDuration.is_stopped():
			$Light2D/LightDuration.start()
		else:
			pass
	pass

func _process(delta):
	
	if alive: # Only create velocity when player is alive
		position += velocity * delta
		#look_at(get_global_mouse_position())

func _physics_process(delta):
	if alive: # Only create velocity when player is alive
		get_input()
		animate_player(velocity)
		#get_player_collision()
	else:
		velocity = Vector2()
	velocity = move_and_slide(velocity, Vector2(0, -1))


func _on_LightDuration_timeout():
	light_countdown()


func _on_Player_Dead(cause):
	# Show Death Menu
	$PlayerSprite.play("Death")
	$Light2D/LightDuration.stop()
	$Fade/FadeOverlay.show()
	$Fade/FadeOverlay/FadeAnimation.play("FadeOut")
#if not $Camera2D/FadeOverlay/FadeAnimation.is_playing():
#	
	yield(get_tree().create_timer(1), "timeout")
	get_parent().get_node("PauseMenu/PauseControl/Pause").disabled = true
	get_parent().get_node("DeathMenu/DeathControl/DeathPopup").show()
	#get_tree().call_group("Hideables", "hide")
	get_tree().paused = true
