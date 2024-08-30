extends CharacterBody2D

@export var speed := 500
var can_shoot := true
var extra_weapons: bool

signal shoot(pos)

func _ready():
	extra_weapons = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	if DisplayServer.is_touchscreen_available():
		var mobile = get_tree().get_first_node_in_group("mobile_buttons")
		if mobile.get_child(6).is_pressed() and can_shoot:
			shoot.emit($LaserStartPos.global_position)
			can_shoot = false
			$ShootCountdown.start()
			$LaserSound.play()
	elif Input.is_action_just_pressed("shoot") and can_shoot and !DisplayServer.is_touchscreen_available():
		shoot.emit($LaserStartPos.global_position)
		can_shoot = false
		$ShootCountdown.start()
		$LaserSound.play()

func _on_shoot_countdown_timeout():
	can_shoot = true


func _on_shoot_time_reset_timer_timeout():
	$WeaponsPowerDown.play()
	$ShootCountdown.wait_time = 0.25
	extra_weapons = false
