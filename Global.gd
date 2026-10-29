extends Node2D

@export var timer_cooldown = 0.2

var global_timer = 1

signal ticked(update: int)
@onready var timer := Timer.new()

func _ready() -> void:
	add_child(timer)
	timer.wait_time = timer_cooldown
	timer.timeout.connect(_timeout)
	timer.ignore_time_scale = true
	timer.start()

func _timeout():
	print("send ts")
	ticked.emit()
