extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.collectedFood.connect(_update_hud)
	_update_hud()


func _update_hud():
	print("updated hud")
	$Label.text =  "(" +str( GameManager.foot_eaten)+ " / " +str( GameManager.food_total)+ ")" 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
