extends VBoxContainer

var debug_obj_script = preload("res://addons/godot-debug-utility/debug_obj.gd")

var debug_objects = []

func _ready():
	add_child(create_obj("FPS", funcref(Performance, "get_monitor"), [0]))
	add_child(create_obj("Frame time (Seconds)", funcref(Performance, "get_monitor"), [1]))
	add_child(HSeparator.new())
	add_child(create_obj("Draw calls (Current frame)", funcref(Performance, "get_monitor"), [19]))
	add_child(create_obj("Node count", funcref(Performance, "get_monitor"), [10]))
	add_child(HSeparator.new())
	add_child(create_obj("Engine version", funcref(Engine, "get_version_info"), null))
	add_child(create_obj("OS name", funcref(OS, "get_name"), null))
	add_child(create_obj("Is debug build", funcref(OS, "is_debug_build"), null))

	for obj in get_children():
		if obj is Label:
			debug_objects.append(obj)
	
func _process(delta):
	for obj in debug_objects:
		obj.update_self()
		
func _input(event):
	var just_pressed = event.is_pressed() and not event.is_echo()
	if Input.is_key_pressed(KEY_F3) and just_pressed:
		visible = !visible
		
func create_obj(txt_name, var_get, arg):
	var obj = Label.new()
	#obj.text = txt_name + ":" + str(var_get.call_func())
	obj.set_script(debug_obj_script)
	obj.debug_func = var_get
	obj.text_to_show = txt_name
	obj.args = arg
	
	return obj
