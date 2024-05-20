extends Area2D

class_name Card
var blue_card:AnimatedSprite2D
@onready var card_animation = $card
signal card_pickup(card: Card)

func _ready():
	card_animation.play("card")
	
func _on_body_entered(body):
	$PickUp.play()
	if body is Player:
		$PickUp.play()
		card_pickup.emit(self)
		queue_free()
		var cards = get_tree().get_nodes_in_group("Cards")
		print(cards.size())
		if cards.size() == 1:
			var parent = get_parent().get_parent()
			var door = parent.get_node("Door/Door") 
			if door:
				door.card_count_is_one()
				
				

