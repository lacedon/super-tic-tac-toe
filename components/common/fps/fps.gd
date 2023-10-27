extends Label
class_name FPSMeter

const TIMER_LIMIT: = 1.0
var timer: = 0.0
var isHidden: bool = false

func _ready():
  if !gameSettings.shouldShowFPS:
    hide()
    isHidden = true
    return

  add_theme_color_override("font_color", Color(0,0,0,1))
  add_theme_color_override("font_outline_color", Color(1,1,1,1))
  add_theme_font_size_override('font_size', 32)
  add_theme_constant_override('outline_size', 64)

func _process(delta: float):
  if isHidden: return

  timer += delta
  if timer > TIMER_LIMIT:
      timer = 0.0
      text = "fps: " + str(Engine.get_frames_per_second())
