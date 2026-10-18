extends PathFollow2D

var speed: float = 0.1

# Llamada cuando el nodo entra en el arbol de escenas por primera vez.
func _ready():
	pass # Replace with function body.


# Llamada en cada 'frame'. 'delta' es el tiempo transcurrido desde el anterior 'frame'.
func _process(delta):
	progress_ratio += delta * speed
