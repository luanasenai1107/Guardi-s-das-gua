extends CharacterBody2D

@onready var animador: AnimationPlayer = $Animador
@onready var textura: Sprite2D = $Textura

const VELOCIDADE_CAMINHADA: float = 150.0
const VELOCIDADE_CORRIDA: float = 280.0


func _ready() -> void:
	add_to_group("jogador")


func _physics_process(_delta: float) -> void:
	var direcao = Input.get_vector(
		"mover_esquerda", "mover_direita",
		"mover_cima", "mover_baixo"
	)

	var velocidade = VELOCIDADE_CORRIDA if Input.is_action_pressed("Run") else VELOCIDADE_CAMINHADA
	velocity = direcao.normalized() * velocidade
	move_and_slide()

	_atualizar_animacao(direcao)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interagir"):
		if Global.perto_da_lixeira and Global.lixo_no_bolso > 0:
			_descartar_lixo()


func _descartar_lixo() -> void:
	Global.lixo_total_descartado += Global.lixo_no_bolso
	Global.lixo_no_bolso = 0


func _atualizar_animacao(direcao: Vector2) -> void:
	if direcao == Vector2.ZERO:
		_tocar_animacao("Idle")
		return

	var correndo = Input.is_action_pressed("Run")

	if abs(direcao.y) > abs(direcao.x):
		if direcao.y > 0:
			_tocar_animacao("Run Down" if correndo else "Down")
		else:
			_tocar_animacao("Run Up" if correndo else "Up")
	else:
		textura.flip_h = direcao.x < 0
		_tocar_animacao("Run" if correndo else "Walk")


func _tocar_animacao(nome: String) -> void:
	if animador.current_animation != nome:
		animador.play(nome)
