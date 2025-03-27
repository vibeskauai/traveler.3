extends Node

var current_tilemap_bounds : Array
signal TileMapBoundsChanged(bounds : Array)

func ChangeTileMapBounds(bounds : Array) -> void:
	current_tilemap_bounds = bounds
	TileMapBoundsChanged.emit(bounds)
