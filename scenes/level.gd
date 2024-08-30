extends Node2D

var meteor_scene: PackedScene = load("res://scenes/meteor.tscn")
var laser_scene: PackedScene = load("res://scenes/laser.tscn")
var star_scene: PackedScene = load("res://scenes/star.tscn")
var power_up_scene: PackedScene = load("res://scenes/power_up.tscn")
var shield_scene: PackedScene = load("res://scenes/shield.tscn")
var fire_scene: PackedScene = load("res://scenes/fire_wave.tscn")
var ally_scene: PackedScene = load("res://scenes/ally.tscn")

@export var star_count: int = 20
@export var health: int = 5

const ally_count_max: int = 2
var ally_count = 0

func _ready():
	get_tree().call_group('ui', '_set_health', health)
	Global.score = 0
	$Audio/GameMusic.play()
	

func _on_spawner_timeout():
	var meteor = meteor_scene.instantiate()
	$Meteors.add_child(meteor)
	
	meteor.connect('collision', _on_meteor_collision)
	meteor.connect('destroyed', _on_meteor_destroyed)

func _on_meteor_collision():
	var shield
	
	if get_tree().has_group('shield'):
		shield = get_tree().get_nodes_in_group('shield')
	
	if shield == null:
		health -= 1
		get_tree().call_group('ui', '_set_health', health)
		$Audio/Damage.play()
		if health <= 0:
			get_tree().call_deferred('change_scene_to_file', "res://scenes/game_over.tscn")

func _on_player_shoot(pos):
	var laser = laser_scene.instantiate()
	$Lasers.add_child(laser)
	laser.position = pos
	if $Player.extra_weapons:
			var left_laser = laser_scene.instantiate()
			var right_laser = laser_scene.instantiate()
			
			$Lasers.add_child(left_laser)
			$Lasers.add_child(right_laser)
			
			left_laser.position = $Player/LeftGunPos.global_position
			right_laser.position = $Player/RightGunPos.global_position
	

func _on_star_spawner_timeout():
	var star = star_scene.instantiate()
	$Stars.add_child(star)


func _on_power_up_spawner_timeout():
	var power_up = power_up_scene.instantiate()
	$PowerUps.add_child(power_up)
	
	power_up.connect('tractor_beam', _on_tractor_beam)

func _on_tractor_beam(power, _ship):
	match power:
		"Power":
			var fire_wave = fire_scene.instantiate()
			fire_wave.position = $Markers/FireWaveStartPos.position
			call_deferred("add_child", fire_wave)
		"Health":
			if health <= 4:
				health += 1
				$Audio/HealthUp.play()
			get_tree().call_group('ui', '_set_health', health)
		"Shield":
			var shield = shield_scene.instantiate()
			add_child(shield)
		"Help":
			$Audio/Comms.play()
			
			if ally_count < ally_count_max:
				var ally = ally_scene.instantiate()
				call_deferred("add_child", ally)
				ally.connect('arrive', _on_ally_arrive)
				ally.emit_signal('arrive', ally, $Markers/AllyPos1.global_position, $Markers/AllyPos2.global_position)
				ally.connect('shoot', _on_ally_shoot)
				ally.connect('reset', _on_ally_reset)
				ally_count += 1
				
				var ally2 = ally_scene.instantiate()
				call_deferred("add_child", ally2)
				ally2.connect('arrive', _on_ally_arrive)
				ally2.emit_signal('arrive', ally2, $Markers/AllyPos3.global_position, $Markers/AllyPos4.global_position)
				ally2.connect('shoot', _on_ally_shoot)
				ally2.connect('reset', _on_ally_reset)
				ally_count += 1
		"Weapon":
			if !$Player.extra_weapons:
				$Audio/WeaponsPowerUp.play()
				$Player/ShootCountdown.wait_time = 0.1
				$Player.extra_weapons = true
				$Player/ShootTimeResetTimer.start()
			else:
				$Player/ShootTimeResetTimer.stop()
				$Player/ShootTimeResetTimer.start()
		


func _on_ally_shoot(pos1, pos2, pos3):
	var laser1 = laser_scene.instantiate()
	var laser2 = laser_scene.instantiate()
	var laser3 = laser_scene.instantiate()
	
	$Lasers.add_child(laser1)
	$Lasers.add_child(laser2)
	$Lasers.add_child(laser3)
	
	laser1.position = pos1
	laser2.position = pos2
	laser3.position = pos3
	
	var green_laser: Texture2D = load("res://Assets/PNG/Lasers/laserGreen11.png")
	laser1.get_child(0).texture = green_laser
	laser2.get_child(0).texture = green_laser
	laser3.get_child(0).texture = green_laser


func _on_ally_reset():
	ally_count = 0

func _on_ally_arrive(ally_body, start_pos, end_pos):
	var tween = create_tween()
	tween.tween_property(ally_body, "position", end_pos, 0.5).from(start_pos)

func _on_meteor_destroyed():
	$Audio/Destruction.play()
