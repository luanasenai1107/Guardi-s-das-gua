extends Area2D

# Caminho para a cena de destino (ex: "res://cenas/cena_pantanal.tscn")
@export_file("*.tscn") var cena_destino: String = ""

# Lado pelo qual a jogadora vai entrar na cena de destino
# "esquerda" = aparece do lado esquerdo da cena de destino
# "direita"  = aparece do lado direito da cena de destino
@export var entrada_no_destino: String = "esquerda"


func _ready() -> void:
	body_entered.connect(_ao_jogadora_entrar)


func _ao_jogadora_entrar(corpo: Node2D) -> void:
	if not corpo.is_in_group("jogador"):
		return
	if cena_destino.is_empty():
		return

	Global.perto_da_lixeira = false
	Global.cena_entrada = entrada_no_destino
	get_tree().change_scene_to_file(cena_destino)
