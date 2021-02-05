extends Label

var text_to_show
var debug_func
var args

func _ready():
	print(name)

func update_self():
	text = text_to_show + ":"
	if args:
		text += str(debug_func.call_funcv(args))
	else:
		text += str(debug_func.call_func())
