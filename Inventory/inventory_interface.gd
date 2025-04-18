extends Control

signal drop_slot_data(slot_data: SlotData)

var grabbed_slot_data: SlotData

@onready var player_inventory: PanelContainer = $InventoryPanel
@onready var grabbed_slot: PanelContainer = $GrabbedSlot
@onready var armor_panel: PanelContainer = $ArmorPanel
@onready var equip_inventory: PanelContainer = $EquipInventory


func _ready():
	$ArmorButton.connect("pressed", Callable(self, "_on_ArmorButton_pressed"))
	$InventoryButton.connect("pressed", Callable(self, "_on_InventoryButton_pressed"))
	$StatsButton.connect("pressed", Callable(self, "_on_StatsButton_pressed"))

func _on_InventoryButton_pressed():
	$InventoryPanel.show()
	$StatsPanel.hide()
	$ArmorPanel.hide()
	
func _on_StatsButton_pressed():
	$InventoryPanel.hide()
	$StatsPanel.show()
	$ArmorPanel.hide()

func _on_ArmorButton_pressed():
	$InventoryPanel.hide()
	$StatsPanel.hide()
	$ArmorPanel.show()
	
func _physics_process(_delta: float) -> void:
	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position() + Vector2(5, 5)

func set_player_inventory_data(inventory_data: InventoryData) -> void:
	inventory_data.inventory_interact.connect(on_inventory_interact)
	player_inventory.set_inventory_data(inventory_data)
	
func set_equip_inventory_data(inventory_data: InventoryData) -> void:
	inventory_data.inventory_interact.connect(on_inventory_interact)
	equip_inventory.set_inventory_data(inventory_data)

#func set_equip_inventory_data(inventory_data: InventoryData) -> void:
#	inventory_data.inventory_interact.connect(on_inventory_interact)
#	armor_panel.set_inventory_data(inventory_data)
	

func on_inventory_interact(inventory_data: InventoryData,
 index: int, button: int) -> void:
	
	match [grabbed_slot_data, button]:
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.grab_slot_data(index)
		[_, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.drop_slot_data(grabbed_slot_data, index)
		[null, MOUSE_BUTTON_RIGHT]:
			var slot_data = inventory_data.slot_datas[index]
		[_, MOUSE_BUTTON_RIGHT]:
			grabbed_slot_data = inventory_data.drop_single_slot_data(grabbed_slot_data, index)
	update_grabbed_slot()


func update_grabbed_slot() -> void:
	if grabbed_slot_data:
		grabbed_slot.show()
		grabbed_slot.set_slot_data(grabbed_slot_data)
	else:
		grabbed_slot.hide()

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and event.is_pressed() \
			and grabbed_slot_data:
				
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				drop_slot_data.emit(grabbed_slot_data)
				print("drop data")
