extends Node2D

@onready var personagem: CharacterBody2D = $Personagem
@onready var spawn_esquerda: Marker2D = $SpawnEsquerda
@onready var spawn_direita: Marker2D = $SpawnDireita


func _ready() -> void:
	if Global.cena_entrada == "direita":
		personagem.global_position = spawn_direita.global_position
	else:
		personagem.global_position = spawn_esquerda.global_position
