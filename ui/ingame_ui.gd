extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.collectedFood.connect(_update_hud)


func _update_hud():
	$Label.text =  "(" +str( GameManager.food_total)+ " / " +str( GameManager.food_total)+ ")" 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
