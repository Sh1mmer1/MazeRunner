extends Area2D

class_name Card
var blue_card:AnimatedSprite2D

signal card_pickup(card: Card)

func _ready():
	blue_card = $blue_card
	blue_card.play("blue_card_")
	
func _on_body_entered(body):
	if body is Player:
		card_pickup.emit(self)
		queue_free()
		
