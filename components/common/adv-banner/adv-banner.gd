extends Panel

const androidUnitId = "ca-app-pub-7241726601843025/6699809132"

var ad_view: AdView
var ad_listener := AdListener.new()

func _ready():
	if OS.get_name() != "Android": return

	ad_listener.on_ad_loaded = _on_ad_loaded

	var adSizecurrent_orientation := (
		AdSize.get_current_orientation_anchored_adaptive_banner_ad_size(AdSize.FULL_WIDTH)
	)

	ad_view = AdView.new(androidUnitId, adSizecurrent_orientation, AdPosition.Values.BOTTOM)
	ad_view.ad_listener = ad_listener

	var ad_request := AdRequest.new()
	ad_view.load_ad(ad_request)

func _on_ad_loaded():
	if ad_view: ad_view.show()
