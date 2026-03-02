extends Area2D


func _ready() -> void:
	body_entered.connect(_ao_jogadora_entrar)
	body_exited.connect(_ao_jogadora_sair)
	queue_redraw()


func _draw() -> void:
	var cor_lixeira = Color(0.25, 0.25, 0.25)
	var cor_borda = Color(0.4, 0.4, 0.4)
	var cor_simbolo = Color(0.2, 0.8, 0.3)

	# Corpo principal da lixeira
	draw_rect(Rect2(-22, -50, 44, 56), cor_lixeira)

	# Borda (contorno)
	draw_rect(Rect2(-22, -50, 44, 56), cor_borda, false, 2.0)

	# Tampa com inclinação simulada
	var pontos_tampa = PackedVector2Array([
		Vector2(-24, -50),
		Vector2(24, -50),
		Vector2(20, -60),
		Vector2(-20, -60),
	])
	draw_colored_polygon(pontos_tampa, cor_borda)

	# Símbolo de reciclagem (círculo com seta)
	draw_arc(Vector2(0, -25), 12, 0, TAU, 20, cor_simbolo, 2.0)
	draw_line(Vector2(0, -37), Vector2(5, -30), cor_simbolo, 2.0)
	draw_line(Vector2(0, -37), Vector2(-5, -30), cor_simbolo, 2.0)

	# Listras verticais decorativas
	draw_line(Vector2(-8, -48), Vector2(-8, -2), Color(0.35, 0.35, 0.35), 1.5)
	draw_line(Vector2(8, -48), Vector2(8, -2), Color(0.35, 0.35, 0.35), 1.5)


func _ao_jogadora_entrar(corpo: Node2D) -> void:
	if corpo.is_in_group("jogador"):
		Global.perto_da_lixeira = true


func _ao_jogadora_sair(corpo: Node2D) -> void:
	if corpo.is_in_group("jogador"):
		Global.perto_da_lixeira = false
