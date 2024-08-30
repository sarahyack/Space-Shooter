extends Control

@export var first_level: PackedScene
var star_scene: PackedScene = load("res://scenes/star.tscn")
var panel_scene: PackedScene = load("res://scenes/control_panel.tscn")

func _ready():
	$TitleMusic.play()
	$ControlPanel.visible = false
	if DisplayServer.is_touchscreen_available():
		$VBoxContainer/Controls.hide()

func _on_play_pressed():
	get_tree().call_deferred("change_scene_to_packed", first_level)

func _on_exit_pressed():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()


func _on_star_spawner_timeout():
	var star = star_scene.instantiate()
	$Decor/Stars.add_child(star)


func _on_controls_toggled(_toggled_on):
	$ControlPanel.visible = !$ControlPanel.visible
