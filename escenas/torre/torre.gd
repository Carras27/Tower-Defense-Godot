class_name Torre
extends CharacterBody2D

@export var animacion: AnimatedSprite2D
@export var area_2d: Area2D
@export var escena_bala: PackedScene
@export var salida_bala: Marker2D
@export var temporizador_cooldown: Timer

var objetivo_actual: Enemigo
var objetivos_totales: Array[Enemigo]
var cooldown: bool = false

# Estados posibles de la torre
enum ESTADO {
	VACIA,
	CUCH1,
	CUCH2,
	CUCH3,
	SAL1,
	SAL2,
	SAL3
}
var estado_actual:ESTADO = ESTADO.VACIA

# Llamada cuando el nodo entra en el arbol de escenas por primera vez.
func _ready():
	input_pickable = true
	
	# Llamar a las funciones cuando el raton pase por la torre.
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
	# Por defecto, la animacion sera 'idle'
	animacion.play("idle")
	
	area_2d.body_entered.connect(_on_area_2d_body_entered)
	area_2d.body_exited.connect(_on_area_2d_body_exited)

# Llamada en cada 'frame'. 'delta' es el tiempo transcurrido desde el anterior 'frame'.
func _process(_delta):
	# Comprueba que haya enemigos al alcance. Fija como objetivo al enemigo mas avanzado.
	if objetivos_totales.size() > 0:
		for obj in objetivos_totales:
			if objetivo_actual == null:
				objetivo_actual = obj
			elif objetivo_actual.get_parent().progress_ratio < obj.get_parent().progress_ratio:
				objetivo_actual = obj
		
		if (estado_actual != ESTADO.SAL3):
			# Llama a la funcion de disparo al enemigo cada vez que el enfriamento lo permite.
			if !cooldown:
				cooldown = true
				disparo()
				temporizador_cooldown.start()
			
	
# Cuando el raton pase por encima de la torre, esta reaccionara.
func _on_mouse_entered():
	animacion.play("hoover")
func _on_mouse_exited():
	animacion.play("idle")

func comprar_torre():
	pass
# Al subir de nivel una torre, cambiara la skin y propiedades de la misma.
func subir_nivel():
	pass

# Creara una bala con direccion al objetivo actual de la torre.
func disparo():
	if escena_bala:
		var bala = escena_bala.instantiate()
		add_child(bala)
		bala.set_target_position(objetivo_actual.global_position)
		bala.global_position = salida_bala.global_position

# Se activara cuando un enemigo entre en el area de alcance de la torre.
func _on_area_2d_body_entered(body):
	if body.is_in_group("enemigos"):
		if !objetivos_totales.has(body): # Si el enemigo no estaba en la lista de objetivos, lo añade.
			objetivos_totales.append(body)

# Se activara cuando un enemigo salga del area de alcance de la torre.
func _on_area_2d_body_exited(body):
	if body.is_in_group("enemigos"):
		if objetivos_totales.has(body): # Si el enemigo estaba en la lista de objetivos, lo saca.
			objetivos_totales.erase(body)

# Cuando el enfriamiento termine, se le indicara a la variable 'cooldown'.
func _on_cooldown_timeout():
	cooldown = false
