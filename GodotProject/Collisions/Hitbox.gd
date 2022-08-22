class_name MyHitbox
extends Area2D

func _ready():
	connect("area_entered", self, "_on_hurtbox_entered")


func _on_hurtbox_entered(hurtbox:Hurtbox):
	if hurtbox == null: return
	
	if owner.has_method("take_damage"): owner.take_damage(hurtbox.damage)
