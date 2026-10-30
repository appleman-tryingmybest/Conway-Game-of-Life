extends Node2D

@export var timer_cooldown : float


var global_timer = 1

signal ticked(update: int)
@onready var timer := Timer.new()

func _ready() -> void:
	add_child(timer)s
	timer.wait_time = 0.7
	timer.timeout.connect(_timeout)
	timer.start()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept") and !timer.paused:
		timer.paused = true
	elif Input.is_action_just_pressed("ui_accept") and timer.paused:
		timer.paused = false

func _timeout():
	ticked.emit()
