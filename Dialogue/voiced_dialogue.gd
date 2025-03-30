extends Node

@export var voice_lines: Array[AudioStream] = []
@export var play_once: bool = false

@onready var audio_player: AudioStreamPlayer = $"../AudioStreamPlayer"
@onready var interaction_area: Node = $"../InteractionArea"

var finished := false
var current_index := 0

func _ready():
	audio_player.connect("finished", Callable(self, "_on_audio_finished"))
	if interaction_area.has_signal("interacted"):
		interaction_area.connect("interacted", Callable(self, "_on_interact"))

func _on_audio_finished():
	if current_index >= voice_lines.size():
		_end_dialogue()

func _on_interact():
	if finished or audio_player.playing:
		return

	if current_index < voice_lines.size():
		audio_player.stream = voice_lines[current_index]
		audio_player.play()
		current_index += 1
	else:
		_end_dialogue()

func _end_dialogue():
	current_index = 0

	if play_once:
		finished = true

	var parent = get_parent()
	if parent:
		for child in parent.get_children():
			if child.name == "GivePickaxe" and child.has_method("_on_dialogue_finished"):
				child._on_dialogue_finished()
