extends Node

# Quantidade de lixo que a jogadora está carregando no momento
var lixo_no_bolso: int = 0

# Total de lixo já descartado corretamente na lixeira
var lixo_total_descartado: int = 0

# Indica por qual lado a jogadora deve aparecer ao trocar de cena
# "esquerda" = aparece no lado esquerdo, "direita" = no lado direito
var cena_entrada: String = "esquerda"

# Flag que indica se a jogadora está próxima de uma lixeira
var perto_da_lixeira: bool = false
