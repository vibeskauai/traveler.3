extends CanvasModulate

const DAY_COLOR = Color("#ffffff")
const NIGHT_COLOR = Color("#57add0")
const TIME_SCALE = 0.005 # controls length of cycles

var time = 0

func _process(delta: float) -> void:
	self.time += delta * TIME_SCALE
	self.color = DAY_COLOR.lerp(NIGHT_COLOR, abs(sin(time)))
