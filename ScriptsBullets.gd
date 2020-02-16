extends Node2D

var ready = true
onready var default_timer = $Timer.wait_time

func _ready():
	pass

func fire(b):
	if ready:
		add_child(b)
		ready = false
		$Timer.start()


func _on_Timer_timeout():
	ready = true
