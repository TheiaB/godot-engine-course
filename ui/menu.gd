extends Control

@export var level:PackedScene

func _ready() -> void:
	%PlayButton.grab_focus()

func _on_play_button_pressed() -> void:
	print("Play Level")
	get_tree().change_scene_to_packed(level)

func _on_quit_button_pressed() -> void:
	print("Quit Game")
	get_tree().quit()

func _on_volume_slider_value_changed(value: float) -> void:
	%VolumeLabel.text = "Volume "+str(value)



func _physics_process(delta: float):
	
	var move_input = Input.get_vector('left', 'right', 'backward', 'forward')
	
	move_input = Vector2(1,0)
	
	print(move_input)
	pass
	
