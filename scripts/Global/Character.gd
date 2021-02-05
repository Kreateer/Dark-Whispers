extends KinematicBody2D

"""
This class provides general functionality for beings in the game. 
"""

signal Dead(cause)
signal Damaged

export (int) var movement_speed = 30
export (int) var gravity = 1200
export (int) var jump_speed = -400

var health = max_health
var max_health = 100
var jumping = false
var alive = true
var velocity = Vector2()

# Edges equals settings limit of Player.camera2D
var edge_lvl_r = 2856
var edge_lvl_l = 0

var screen_size # Empty var to hold screen size
var origin = Vector2()

func get_damage(amount):
	if alive:
		health -= amount
		emit_signal("Damaged")
		if health <= 0:
			_die(Globals.HEALTH)
		else:
			print("Damaged {0} points".format([amount]))
			print("Current health: {0} points".format([health]))


# Main death function
func _die(cause):
	if alive:
		alive = false
		emit_signal("Dead", cause)
