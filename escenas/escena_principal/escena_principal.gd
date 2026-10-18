extends Node2D

@export var niveles: Array[PackedScene] # Array con todos los niveles disponibles

var _nivel_actual: int = 0
var _nivel_instanciado: Node

# Llamada cuando el nodo entra en el arbol de escenas por primera vez.
func _ready():
	_crear_nivel(0)

# Crea el nivel señalado por el parametro de entrada.
func _crear_nivel(numero_nivel: int):
	_nivel_instanciado = niveles[numero_nivel].instantiate()
	add_child(_nivel_instanciado)

# Elimina el nivel del arbol de escenas.
func _eliminar_nivel():
	_nivel_instanciado.queue_free()

# Elimina y crea el nivel de nuevo.
func _reiniciar_nivel():
	_eliminar_nivel()
	_crear_nivel.call_deferred(_nivel_actual)

# Vuelve al menu de niveles.
func _terminar_nivel():
	_eliminar_nivel()
	_nivel_actual = 0
	_crear_nivel(0)
	
