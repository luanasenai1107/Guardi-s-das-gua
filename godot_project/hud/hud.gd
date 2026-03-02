extends CanvasLayer

# Controla se o painel de instrucoes deve aparecer nesta cena
@export var mostrar_instrucoes: bool = true

@onready var label_bolso: Label = $PainelInfo/VBox/LabelBolso
@onready var label_descartado: Label = $PainelInfo/VBox/LabelDescartado
@onready var label_prompt: Label = $LabelPrompt
@onready var painel_instrucoes: Panel = $PainelInstrucoes
@onready var btn_comecar: Button = $PainelInstrucoes/VBox/BtnComecar


func _ready() -> void:
	btn_comecar.pressed.connect(_fechar_instrucoes)
	painel_instrucoes.visible = mostrar_instrucoes


func _process(_delta: float) -> void:
	label_bolso.text = "Lixo coletado: %d" % Global.lixo_no_bolso
	label_descartado.text = "Total descartado: %d" % Global.lixo_total_descartado

	_atualizar_prompt()


func _atualizar_prompt() -> void:
	if Global.perto_da_lixeira:
		if Global.lixo_no_bolso > 0:
			label_prompt.text = "Pressione E para descartar o lixo (%d)" % Global.lixo_no_bolso
			label_prompt.visible = true
		else:
			label_prompt.text = "Voce nao tem lixo para descartar"
			label_prompt.visible = true
	else:
		label_prompt.visible = false


func _fechar_instrucoes() -> void:
	painel_instrucoes.visible = false
