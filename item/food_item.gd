extends Area3D


func _ready():
	$AnimationPlayer.play("hover")
	GameManager.food_total += 1


func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if(body is CharacterBody3D):
		set_deferred("monitoring", false)
		print("monitoring false")
		$AudioStreamPlayer3D.play()
		hide()
		GameManager.foot_eaten += 1
		GameManager.collectedFood.emit()
		#$AnimationPlayer.play("death")
		#queue_free()


func _on_audio_stream_player_3d_finished() -> void:
	queue_free()
	pass # Replace with function body.
