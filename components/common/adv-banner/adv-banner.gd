extends Panel

const androidUnitId: String = "ca-app-pub-7241726601843025/6699809132"

var ad_view: AdView
var ad_listener := AdListener.new()

func _ready():
	if OS.get_name() == "Android":
		_createAndLoadBanner(androidUnitId)
		ad_view.show()

func _exit_tree():
	if ad_view:
		ad_view.hide()

func _on_ad_loaded():
	if ad_view: ad_view.show()

func _createAndLoadBanner(unitId: String):
	ad_listener.on_ad_loaded = _on_ad_loaded

	var adSizecurrent_orientation := (
		AdSize.get_current_orientation_anchored_adaptive_banner_ad_size(AdSize.FULL_WIDTH)
	)

	ad_view = AdView.new(unitId, adSizecurrent_orientation, AdPosition.Values.BOTTOM)
	ad_view.ad_listener = ad_listener

	var ad_request := AdRequest.new()
	ad_view.load_ad(ad_request)
