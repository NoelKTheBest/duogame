extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	$CharacterBody2D/Camera2D/Label.text = "YOU WIN"
	$CharacterBody2D/Timer.start()


func _on_timer_timeout() -> void:
	get_tree().quit()
