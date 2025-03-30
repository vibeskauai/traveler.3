extends Node

@export var item_to_give: SlotData
@onready var interaction_area: Area2D = get_parent().get_node("InteractionArea")

var given := false

func _ready():
	if interaction_area and interaction_area.has_signal("interacted"):
		interaction_area.connect("interacted", Callable(self, "_on_interact"))

func _on_interact():
	if given:
		return

	var player = get_tree().current_scene.get_node("Player")
	if player == null:
		return

	var inventory_data = player.inventory_data
	if inventory_data == null:
		return

	if item_to_give == null:
		return

	var slot_data = item_to_give.duplicate()
	if inventory_data.pick_up_slot_data(slot_data):
		given = true

	var popup_label = get_tree().current_scene.get_node_or_null("UI/ItemPopupLabel")
	if popup_label:
		popup_label.show_item(slot_data)
