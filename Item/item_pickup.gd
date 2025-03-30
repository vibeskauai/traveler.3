extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var slot_data: SlotData
@export var item_data: ItemData

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	if sprite_2d.texture != null:
		var player = get_tree().current_scene.get_node("Player")
		if player != null:
			var inventory_data = player.inventory_data
			if inventory_data.pick_up_slot_data(slot_data):
				var popup_label = get_tree().current_scene.get_node_or_null("UI/ItemPopupLabel")
				if popup_label:
					popup_label.show_item(slot_data)

				await get_tree().create_timer(1.25).timeout
				sprite_2d.queue_free()
				interactable.is_interactable = false
			else:
				print("Inventory is full, cannot pick up item.")
		else:
			print("Player node not found!")
