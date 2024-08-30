extends CharacterBody2D

@export var amount: int
@export var starting_positions: Array[Vector2]
var leaving = false

signal shoot(pos1, pos2, pos3)
signal reset()
signal arrive(start_pos, end_pos)

func _ready():
	$Arrival.play()
	leaving = false
	
func _process(delta):
	if leaving == true:
		position += delta * 300 * Vector2(0.0, -1.0)

func _on_shoot_time_timeout():
	shoot.emit($FrontLaserPosition.global_position, $LeftLaserPosition.global_position, $RightLaserPosition.global_position)
	$AllyLaserSound.play()


func _on_reset_timer_timeout():
	reset.emit()
	leaving = true


func _on_destroy_timer_timeout():
	queue_free()
