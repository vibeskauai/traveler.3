class_name LevelTileMap extends TileMap



func _ready() -> void:
	LevelManager.ChangeTileMapBounds( GetTileMapBounds() )
	
func GetTileMapBounds() -> Array:
	var bounds : Array = []
	bounds.append(Vector2(get_used_rect().position * rendering_quadrant_size))
	bounds.append(Vector2(get_used_rect().end * rendering_quadrant_size))
	return bounds
