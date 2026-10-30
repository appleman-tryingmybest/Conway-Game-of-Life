@tool
extends GridContainer

@export var width = 0:
	set(value):
		width = value
		_rebuild()

@export var height = 0:
	set(value):
		height = value
		_rebuild()

@export var cell_width = 0:
	set(value):
		cell_width = value
		_rebuild()

@export var cell_height = 1:
	set(value):
		cell_height = value
		_rebuild()


var grid_cell = preload("res://grid_panel.tscn")
var col_shape = preload("res://grid_panel.tscn::RectangleShape2D_emoma")
var det_shape = preload("res://grid_panel.tscn::RectangleShape2D_5le0k")
var border_size = 2
var _queued := false


func _ready() -> void:
	_rebuild()


# Coalesce the four exported properties into a single rebuild. Setting width,
# height, cell_width and cell_height in a row now costs one rebuild, not four.
func _rebuild() -> void:
	if _queued:
		return
	_queued = true
	_do_rebuild.call_deferred()


func _do_rebuild() -> void:
	_queued = false
	_remove_grid()
	_create_grid()


func _create_grid() -> void:
	col_shape.size = Vector2(cell_width, cell_height)
	det_shape.size = Vector2(cell_width * 2, cell_height * 2)
	columns = width
	for i in width * height:
		var grid_cell_node = grid_cell.instantiate()
		grid_cell_node.custom_minimum_size = Vector2(cell_width, cell_height)
		add_child(grid_cell_node)


# remove_child() takes the node out of the tree immediately, so the next
# _create_grid() starts from zero. queue_free() alone defers until the end of
# the frame, which never arrives during scene loading.
func _remove_grid() -> void:
	for node in get_children():
		remove_child(node)
		node.queue_free()
