extends Control

@export var level_scene: PackedScene
@export var title_scene: PackedScene

func _ready():
	$CenterContainer/VBoxContainer/Score.text += str(Global.score)
	$Lose.play()
	if DisplayServer.is_touchscreen_available():
		$MarginContainer/StartAgain.text = "Tap To Start Again"
		$MobileControls/TouchLeft.hide()
		$MobileControls/TouchRight.hide()
		$MobileControls/TouchUp.hide()
		$MobileControls/TouchDown.hide()
		$MobileControls/TouchShoot.hide()
	elif Input.get_connected_joypads().size() != 0:
		$MarginContainer/StartAgain.text = "Press A to Start Again or Y to Quit"

func _input(event):
	if event.is_action_pressed('interact') and $MobileControls/TouchMenu.is_pressed() != true:
		get_tree().call_deferred('change_scene_to_packed', level_scene)
	if event.is_action_pressed('return'):
		get_tree().call_deferred('change_scene_to_packed', title_scene)
	if event.is_action_pressed("quit"):
		get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
		get_tree().quit()
