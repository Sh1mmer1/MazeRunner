extends Area2D

class_name Card
var blue_card:AnimatedSprite2D

signal card_pickup(card: Card)

func _ready():
	blue_card = $blue_card
	blue_card.play("blue_card_")
	
func _on_body_entered(body):
	if body is Player:
		$PickUp.play()
		card_pickup.emit(self)
		queue_free()
		var cards = get_tree().get_nodes_in_group("Cards")
		if cards.size() == 1:
			var parent = get_parent().get_parent()
			var door = parent.get_node("Door/Door") 
			if door:
				door.card_count_is_one()
				
				

