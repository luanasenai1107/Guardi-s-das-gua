extends Area2D

# Cor do item, permite criar variações visuais por cenário
@export var cor: Color = Color(1.0, 0.85, 0.1)

# Tempo em segundos até o item reaparecer após ser coletado
@export var tempo_respawn: float = 12.0

@onready var timer_respawn: Timer = $TimerRespawn


func _ready() -> void:
	body_entered.connect(_ao_jogadora_chegar)
	timer_respawn.timeout.connect(_ao_reaparecer)
	timer_respawn.wait_time = tempo_respawn
	timer_respawn.one_shot = true
	queue_redraw()


func _draw() -> void:
	if not visible:
		return

	# Corpo da lata/lixo (retângulo principal)
	draw_rect(Rect2(-7, -14, 14, 16), cor)

	# Tampa superior (levemente mais escura)
	var cor_tampa = cor.darkened(0.25)
	draw_rect(Rect2(-9, -18, 18, 5), cor_tampa)

	# Alça no topo
	draw_arc(Vector2(0, -18), 4, PI, 0.0, 8, Color.WHITE, 1.5)

	# Brilho sutil para indicar que é coletável
	draw_line(Vector2(-4, -13), Vector2(-4, -3), Color(1, 1, 1, 0.3), 2)


func _ao_jogadora_chegar(corpo: Node2D) -> void:
	if corpo.is_in_group("jogador"):
		_coletar()


func _coletar() -> void:
	monitoring = false
	visible = false
	Global.lixo_no_bolso += 1
	timer_respawn.start()


func _ao_reaparecer() -> void:
	visible = true
	monitoring = true
	queue_redraw()
