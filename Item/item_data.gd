extends Resource
class_name ItemData

@export var name: String = ""
@export_multiline var description: String = ""
@export var item_type: String = ""  # tools, weapon, armor, resource, etc.
@export var stackable: bool = false
@export var texture: Texture
@export var can_equip: bool = false  # ores are not equippable
@export var equip_slot: String = ""  # unused for ores
@export var stats_resource: StatsResource = null 
@export var next_upgrade: ItemData
@export var upgrade_recipe: Array[ItemData]
