extends CharacterBody2D
class_name PersonagemBase

@onready var _animador: AnimationPlayer = $Animador
@onready var _textura: Sprite2D = $Textura

@export var _velocidade_de_movimento: float = 150.0
@export var _velocidade_de_corrida: float = 300.0

func _physics_process(_delta: float) -> void:
	var direcao = Input.get_vector(
		"mover_esquerda", "mover_direita",
		"mover_cima", "mover_baixo"
	)
	
	# Corrigido: GDScript não usa ?:
	var velocidade_atual = _velocidade_de_movimento
	if Input.is_action_pressed("Run"):
		velocidade_atual = _velocidade_de_corrida
	
	velocity = direcao.normalized() * velocidade_atual
	move_and_slide()
	
	_tratar_animacoes(direcao)


func _tratar_animacoes(direcao: Vector2) -> void:
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
		_textura.flip_h = direcao.x < 0
		_tocar_animacao("Run" if correndo else "Walk")


func _tocar_animacao(nome: String) -> void:
	if _animador.current_animation != nome:
		_animador.play(nome)
