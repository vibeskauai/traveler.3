extends Area2D

signal interacted

var player_inside := false

func _ready():
	monitoring = true
	input_pickable = true
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.name == "Player": # or use body.is_in_group("player") if grouped
		player_inside = true

func _on_body_exited(body):
	if body.name == "Player":
		player_inside = false

func _input_event(_viewport, event, _shape_idx):
	if not player_inside:
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		emit_signal("interacted")
