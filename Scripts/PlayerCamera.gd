extends Camera2D

func _ready() -> void:
	LevelManager.TileMapBoundsChanged.connect(UpdateLimits)
	UpdateLimits(LevelManager.current_tilemap_bounds)

func UpdateLimits(bounds : Array) -> void:
	if bounds.size() >= 2 and bounds[0] is Vector2 and bounds[1] is Vector2:
		limit_left = int(bounds[0].x)
		limit_top = int(bounds[0].y)
		limit_right = int(bounds[1].x)
		limit_bottom = int(bounds[1].y)
