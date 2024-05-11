extends Area2D

class_name Card_Green
var green_card:AnimatedSprite2D

signal card_pickup(card: Card_Green)

func _ready():
	green_card = $green_card
	green_card.play("green_card_")
	

func _on_body_entered(body):
	if body is Player:
		card_pickup.emit(self)
		$PickUp.play()
		queue_free()
		
