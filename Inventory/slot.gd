extends PanelContainer

signal slot_clicked(index: int, button: int)
const SLOT_MENU_SCENE: PackedScene = preload("uid://7mtbm2ux4ubq")

@onready var texture_rect: TextureRect = $MarginContainer/TextureRect
@onready var quantity_label: Label = $QuantityLabel

var slot_data: SlotData

func set_slot_data(_slot_data: SlotData) -> void:
	slot_data = _slot_data
	var item_data = slot_data.item_data
	texture_rect.texture = item_data.texture
	
	if slot_data.quantity > 1:
		quantity_label.text = "%s" % slot_data.quantity
		quantity_label.show()
	else:
		quantity_label.hide()

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT \
			and event.is_pressed():
		slot_clicked.emit(get_index(), event.button_index)
	if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_RIGHT \
			and event.is_pressed():
				for node in get_tree().get_nodes_in_group("itemrightclickmenu"):
					node.queue_free()
				var new_menu = SLOT_MENU_SCENE.instantiate()
				World.current_world.get_node("UI").add_child(new_menu)
				new_menu.setup_up(slot_data)
				new_menu.global_position = get_global_mouse_position()
