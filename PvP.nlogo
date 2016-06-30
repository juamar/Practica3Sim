extensions [sound]

breed [nexos nexo]
breed [minions minion]
breed [towers tower]

minions-own [team hp damage cadence critic enemy range additionalDamage]
nexos-own [hp team]
towers-own [team hp damage cadence range enemy critic additionalDamage]

;vuelta es un iterador, foward1 es la distancia que se ha de mover en cada tick la torre para generar el circulo, range1 es el valor de range de las torres.
globals [vuelta foward1 range1 win won1 winner b-hp-value b-dmg-value b-critic-value b-cadence-value r-hp-value r-dmg-value r-critic-value r-cadence-value
  b-wins r-wins b-crit-num r-crit-num b-punches r-punches]


to setup

  clear-all

  reset-ticks

  check-stats

  initialize-variables

  towers-generation

  nexos-generation

  minions-generation

  set win false

  set won1 0

end


to initialize-variables
 set b-wins 0
 set r-wins 0
 set b-crit-num 0
 set r-crit-num 0
 set b-punches 0
 set r-punches 0
end

to towers-generation

  set vuelta 0

  create-towers 1
  [
    set shape "circle"
    set heading 0
    set range 10
    fd range
    set range1 range
    set heading 90
    set color blue
    set team 1 set
    xcor min-pxcor + 20
    set damage 10
    set critic 0
    set cadence 2
    set hp 5000
  ]
  create-towers 1
  [
    set shape "circle"
    set heading 0
    set range 10
    fd range
    set range1 range
    set heading 90
    set color red
    set team 2
    set xcor max-pxcor - 20
    set damage 10
    set critic 0
    set cadence 2
    set hp 5000
  ]

  ;el perimetro del circulo entre 360 movimientos (360 grados...)
  set foward1 (2 * pi * range1) / 360

  while [vuelta < 359]
  [
    ; si vuelta es multiplo de 4, pen down, sino, pen up
    ifelse round (vuelta / 6) * 6 - (vuelta / 6) * 6  = 0
    [
      ask towers [pd]
    ]
    [
      ask towers [pu]
    ]
    ask towers
    [
      fd foward1
      set heading (heading + 1)
    ]
    set vuelta vuelta + 1
  ]
  ask towers [set heading 180 fd range]

end


to nexos-generation

  create-nexos 1 [set shape "nexo" set color blue set size 7 set xcor min-pxcor + 5  set ycor 0 set hp 10000 set team 1]
  create-nexos 1 [set shape "nexo" set color red set size 7 set xcor max-pxcor - 5 set ycor 0 set hp 10000 set team 2]

end


to minions-generation

   ;;minions
  create-minions 1
  [
    set color blue
    set heading 90
    set size 1
    set team 1
    set hp 100
    set damage b-dmg
    set cadence 6 - b-cadence
    set critic b-critic
    set range 1
    set additionalDamage 0
    set xcor min-pxcor + 15
    set ycor 6
  ]

  create-minions 1
  [
    set color blue
    set heading 90
    set size 1
    set team 1
    set hp 100
    set damage b-dmg
    set cadence 6 - b-cadence
    set critic b-critic
    set range 1
    set additionalDamage 0
    set xcor min-pxcor + 15
    set ycor 3
  ]

  create-minions 1
  [
    set color blue
    set heading 90
    set size 1
    set team 1
    set hp 100
    set damage b-dmg
    set cadence 6 - b-cadence
    set critic b-critic
    set range 1
    set additionalDamage 0
    set xcor min-pxcor + 15
    set ycor 0
  ]

  create-minions 1
  [
    set color blue
    set heading 90
    set size 1
    set team 1
    set hp 100
    set damage b-dmg
    set cadence 6 - b-cadence
    set critic b-critic
    set range 1
    set additionalDamage 0
    set xcor min-pxcor + 15
    set ycor -3
  ]

  create-minions 1
  [
    set color blue
    set heading 90
    set size 1
    set team 1
    set hp 100
    set damage b-dmg
    set cadence 6 - b-cadence
    set critic b-critic
    set range 1
    set additionalDamage 0
    set xcor min-pxcor + 15
    set ycor -6
  ]

  create-minions 1
  [
    set color red
    set heading 270
    set size 1
    set team 2
    set hp 100
    set damage r-dmg
    set cadence 6 - r-cadence
    set critic r-critic
    set range 1
    set additionalDamage 0
    set xcor max-pxcor - 15
    set ycor 6
  ]

   create-minions 1
  [
    set color red
    set heading 270
    set size 1
    set team 2
    set hp 100
    set damage r-dmg
    set cadence 6 - r-cadence
    set critic r-critic
    set range 1
    set additionalDamage 0
    set xcor max-pxcor - 15
    set ycor 3
  ]

  create-minions 1
  [
    set color red
    set heading 270
    set size 1
    set team 2
    set hp 100
    set damage r-dmg
    set cadence 6 - r-cadence
    set critic r-critic
    set range 1
    set xcor max-pxcor - 15
    set ycor 0
  ]

  create-minions 1
  [
    set color red
    set heading 270
    set size 1
    set team 2
    set hp 100
    set damage r-dmg
    set cadence 6 - r-cadence
    set critic r-critic
    set range 1
    set additionalDamage 0
    set xcor max-pxcor - 15
    set ycor -3
  ]

  create-minions 1
  [
    set color red
    set heading 270
    set size 1
    set team 2
    set hp 100
    set damage r-dmg
    set cadence 6 - r-cadence
    set critic r-critic
    set range 1
    set additionalDamage 0
    set xcor max-pxcor - 15
    set ycor -6
  ]

  ask minions
  [
    let team1 team
    set enemy min-one-of other minions with [team != team1] [distance myself]
  ]

end


to go

  if round (ticks / 100) * 100 - (ticks / 100) * 100  = 0
  [
    minions-generation
  ]

  if win = true
  [
    stop
  ]
  ask minions
  [
    movement
    if round (ticks / cadence) * cadence  - (ticks / cadence) * cadence  = 0
    [
      punch
    ]
  ]

  ask towers
  [
    if round (ticks / cadence) * cadence - (ticks / cadence) * cadence  = 0
    [
      get_enemy_towers
      punch
    ]
  ]

  ask nexos
  [
    set label hp
  ]

  ask towers
  [
    set label hp
  ]


  tick
end

to movement
  get_enemy
  if enemy = nobody
  [
    set-win-true
    stop
  ]

  face enemy
  ;fd random-float 0.1 rt random-float (0.5 + 0.5) - 0.5
  fd 0.3
end

to punch
  if win = true
  [
    stop
  ]
  ; si es una torre, puede que no tenga enemigo.
  if enemy != nobody
  [
    if distance enemy < range
    [
      get-critic
      let damage1 damage
      set damage1 damage1 + Additionaldamage
      let team1 team
      let critic1 critic

      ask enemy
      [
        set hp hp - damage1

          if team = 2[        ;ask enemy -> entonces, cuando el enemigo recibe un punch, el equipo contrario suma 1 en punches
            set b-punches b-punches + 1
          ]
          if team = 1[
            set r-punches r-punches + 1
          ]

        if hp <= 0
        [
          ;sound:play-sound "Slap.wav"
          die
        ]
      ]
    ]
  ]


end

to get_enemy
  if enemy = nobody
  [
    let team1 team
    set enemy min-one-of other minions with [team != team1] [distance myself]
    if enemy = nobody
    [
      let enemy-tower one-of towers with [team != team1]
      ifelse enemy-tower != nobody
      [
        set enemy enemy-tower
      ]
      [
        set enemy one-of nexos with [team != team1]
      ]
    ]
  ]
end

to get_enemy_towers
  let team1 team
  let range2 range

  set enemy one-of minions in-radius range2 with [team != team1]

  if enemy != nobody
  [
    create-link-with enemy [set color white]
  ]
end

to get-critic

  let critic1 critic
  set additionalDamage 0

  if critic1 = 0[
    set additionalDamage 0
  ]

  if critic1 = 1[
    let random1 random 5
    if random1 = 1 [
      set additionalDamage 3
    ]
  ]

    if critic1 = 2[
    let random1 random 4
    if random1 = 1 [
      set additionalDamage 3
    ]
  ]

  if critic1 = 3[
    let random1 random 3
    if random1 = 1 [
      set additionalDamage 3
    ]
  ]
  if critic1 = 4[
    let random1 random 2
    if random1 = 1 [
      set additionalDamage 3
    ]
  ]


  if additionalDamage != 0 [
    if team = 1[
      set b-crit-num b-crit-num + 1
    ]
    if team = 2[
      set r-crit-num r-crit-num + 1
    ]
  ]

end




to check-stats

  check-blue-stats
  check-red-stats

  if b-hp-value + b-dmg-value + b-critic-value + b-cadence-value > 12
  [
    ;user-message "Equipo Azul: Los stats no estan equilibrados. Equilíbralos!"
  ]

  if b-hp-value + b-dmg-value + b-critic-value + b-cadence-value < 12
  [
    ;user-message "Equipo Azul: Todavía tienes puntos para repartir. Repártelos!"
  ]

  if r-hp-value + r-dmg-value + r-critic-value + r-cadence-value > 12
  [
    ;user-message "Equipo Rojo: Los stats no estan equilibrados. Equilíbralos."
  ]

  if r-hp-value + r-dmg-value + r-critic-value + r-cadence-value < 12
  [
    ;user-message "Equipo Rojo: Todavía tienes puntos para repartir. Repártelos!"
  ]

end

to check-blue-stats

  if b-hp = 100 [set b-hp-value 1]
  if b-hp = 200 [set b-hp-value 2]
  if b-hp = 300 [set b-hp-value 3]
  if b-hp = 400 [set b-hp-value 4]
  if b-hp = 500 [set b-hp-value 5]

  if b-dmg = 1  [set b-dmg-value 1]
  if b-dmg = 2  [set b-dmg-value 2]
  if b-dmg = 3  [set b-dmg-value 3]
  if b-dmg = 4  [set b-dmg-value 4]
  if b-dmg = 5  [set b-dmg-value 5]

  if b-critic = 0 [set b-critic-value 1]
  if b-critic = 1 [set b-critic-value 2]
  if b-critic = 2 [set b-critic-value 3]
  if b-critic = 3 [set b-critic-value 4]
  if b-critic = 4 [set b-critic-value 5]

  if b-cadence = 1 [set b-cadence-value 1]
  if b-cadence = 2 [set b-cadence-value 2]
  if b-cadence = 3 [set b-cadence-value 3]
  if b-cadence = 4 [set b-cadence-value 4]
  if b-cadence = 5 [set b-cadence-value 5]

end

to check-red-stats

  if r-hp = 100 [set r-hp-value 1]
  if r-hp = 200 [set r-hp-value 2]
  if r-hp = 300 [set r-hp-value 3]
  if r-hp = 400 [set r-hp-value 4]
  if r-hp = 500 [set r-hp-value 5]

  if r-dmg = 1  [set r-dmg-value 1]
  if r-dmg = 2  [set r-dmg-value 2]
  if r-dmg = 3  [set r-dmg-value 3]
  if r-dmg = 4  [set r-dmg-value 4]
  if r-dmg = 5  [set r-dmg-value 5]

  if r-critic = 0 [set r-critic-value 1]
  if r-critic = 1 [set r-critic-value 2]
  if r-critic = 2 [set r-critic-value 3]
  if r-critic = 3 [set r-critic-value 4]
  if r-critic = 4 [set r-critic-value 5]

  if r-cadence = 1 [set r-cadence-value 1]
  if r-cadence = 2 [set r-cadence-value 2]
  if r-cadence = 3 [set r-cadence-value 3]
  if r-cadence = 4 [set r-cadence-value 4]
  if r-cadence = 5 [set r-cadence-value 5]

end

to set-win-true
  set win true
  ask nexos
  [
    set winner team
  ]
  print word "win team " team
end

to won
  if winner = 1
  [
    user-message "ha ganado el equipo azul!"
    set b-wins b-wins + 1
  ]

  if winner = 2
  [
    user-message "ha ganado el equipo rojo!"
    set r-wins r-wins + 1
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
330
10
1245
421
34
14
13.13
1
10
1
1
1
0
0
0
1
-34
34
-14
14
1
1
1
ticks
30.0

BUTTON
24
321
258
354
Set-up
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
24
356
258
389
go
ifelse win != true\n[\n go\n]\n[\n if won1 = 0\n [\n  won\n  set won1 won1 + 1\n ]\n]
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

CHOOSER
29
155
121
200
b-critic
b-critic
0 1 2 3 4
3

CHOOSER
29
61
121
106
b-hp
b-hp
100 200 300 400 500
0

CHOOSER
29
108
121
153
b-dmg
b-dmg
1 2 3 4 5
3

TEXTBOX
15
21
141
59
Blue Team Stats
15
0.0
1

TEXTBOX
158
20
308
39
Red Team Stats
15
0.0
1

CHOOSER
166
155
258
200
r-critic
r-critic
0 1 2 3 4
1

CHOOSER
166
61
258
106
r-hp
r-hp
100 200 300 400 500
0

CHOOSER
166
108
258
153
r-dmg
r-dmg
1 2 3 4 5
1

CHOOSER
166
202
258
247
r-cadence
r-cadence
1 2 3 4 5
4

CHOOSER
29
202
121
247
b-cadence
b-cadence
1 2 3 4 5
0

PLOT
431
581
875
842
Número de críticos
NIL
NIL
0.0
1000.0
0.0
1000.0
true
true
"" ""
PENS
"Blue Punches" 1.0 0 -14070903 true "" "plot b-punches"
"Red Punches" 1.0 0 -5298144 true "" "plot r-punches"
"Blue Critics" 1.0 0 -8020277 true "" "plot b-crit-num"
"Red Critics" 1.0 0 -1604481 true "" "plot r-crit-num"

MONITOR
332
580
418
625
Blue Punches
b-punches
17
1
11

MONITOR
332
631
417
676
Red Punches
r-punches
17
1
11

MONITOR
333
682
416
727
Blue Critics
b-crit-num
17
1
11

MONITOR
333
733
415
778
Red Critics
r-crit-num
17
1
11

@#$#@#$#@
Modelatge, Simulació i Optimització

Pràctica 3 - Propuesta

##Descripción general del modelo

Simularemos un pequeño juego que consistirá en un PvP (player vs player) en el que tendremos un mapa, un nexo por jugador y una torre por jugador.

Cada “x” segundos aparecerán un número de minions (oleada) en cada nexo que irán a atacar el nexo enemigo. Primero deberán derrotar a los minions enemigos, luego a las torres, y finalmente al nexo. El primer equipo que destruya al nexo enemigo, gana.

Cada minion tendrá los atributos “ataque”, “vida”, “cadencia” y “crítico”. Cada jugador tendrá “x” puntos a repartir entre estos atributos que se aplicarán a todos los minions de todas las oleadas de una partida.





## Objetivos

Objetivo del modelo:

El objetivo del modelo es ganar la partida, es decir, que tu equipo destruya el nexo enemigo antes que el contrincante.

Objetivo de la simulación:

El objetivo de la simulación consiste en observar qué combinación de valores de atributos es más eficaz para ganar. Para llegar a este objetivo, realizaremos diferentes simulaciones en las que enfrentaremos un atributo contra otro. Por ejemplo:

Simulación 1:

Pondremos los atributos de los dos equipos al mínimo, y a continuación pondremos los valores al máximo de los atributos que queremos enfrentar. En este caso, enfrentamos el atributo “Vida” contra el atributo “Daño”.




		Equipo Azul	Equipo Rojo
Vida		500		100
Daño		1		5
Crítico		0		0
Cadencia	5		5


Después de realizar una serie de simulaciones, extraemos conclusiones. Si existe una clara ventaja de uno de los atributos sobre otro, diremos que ese atributo es eficaz contra el otro.

En este caso concreto, después de varias simulaciones, hemos observado una clara ventaja del atributo “Daño” sobre el atributo “Vida”. Por lo tanto, “Daño” es eficaz contra “Vida”, o dicho de otro modo, vale más la pena invertir puntos en “Daño” que no en “Vida”.




##Diseño preliminar de la solución.

· Entradas:

Los valores de cada minion:

	· Ataque
	· Vida
		· Cadencia
		· Crítico

· Salidas:

	· Informe de la partida (porcentaje de críticos, número de muertes, etc)

· Experimento:

	Realizar diferentes combinaciones de valores para ver cuál es la más efectiva y
observar qué atributos son más efectivos.


· Planificación de actividades:

	· Creación del mapa
	· Creación de nexos y torres
	· Establecer características de las torres (rango, daño, vida, etc)
	· Crear minions
	· Establecer características simples de los minions para hacer que luchen entre ellos
	· Establecer una prioridad de ataque de los minions:
		Minion > Torre > Nexo
	· Establecer reglas de ataque:
		· Solo se puede luchar 1v1 entre minions
		· La torre sólo puede golpear a 1 minion
	· Creación de oleadas cada “x” segundos
	· Establecer valores aleatorios a las características de los minions
	· Establecer la opción de personalizar los valores de los minions


##Experimentación

· Simulación 1: Vida vs Daño


		Equipo Azul	Equipo Rojo
Vida		500		100
Daño		1		5
Crítico		0		0
Cadencia	1		1

Ganador: Daño (100%)


· Simulación 2: Vida vs Crítico



		Equipo Azul	Equipo Rojo
Vida		500		100
Daño		1		1
Crítico		0		4
Cadencia	1		1

Ganador:  Crítico (100%)


· Simulación 3: Vida vs Cadencia



		Equipo Azul	Equipo Rojo
Vida		500		100
Daño		1		1
Crítico		0		0
Cadencia	1		5

Ganador: Cadencia (100%)



· Simulación 4: Daño vs Crítico

		Equipo Azul	Equipo Rojo
Vida		100		100
Daño		5		1
Crítico		0		4
Cadencia	1		1

Ganador: Daño (100%)

Es matemáticamente imposible que Crítico ganase a Daño, ya que aún haciendo golpes críticos un 100% de las veces, el máximo daño que podrían hacer los minions del equipo rojo es 4 (Daño crítico hace 3 puntos de daño).


· Simulación 5: Daño vs Cadencia



		Equipo Azul	Equipo Rojo
Vida		100		100
Daño		5		1
Crítico		0		0
Cadencia	1		5

Ganador: Empate

Las partidas en las que se enfrentan estos dos atributos son extremadamente largas debido al equilibrio existente entre ellos.






Simulación 6: Crítico vs Cadencia




		Equipo Azul	Equipo Rojo
Vida		100		100
Daño		1		1
Crítico		4		0
Cadencia	1		5

Ganador: Cadencia (100%)

Es matemáticamente imposible que Crítico ganase a Cadencia, ya que aún haciendo golpes críticos un 100% de las veces, el máximo daño que podrían hacer los minions del equipo azul es 4 cada 5 ticks, mientras que los minions del equipo hacían 1 punto de daño cada 1 tick (5 cada 5 ticks).


##Conclusiones de los experimentos

Con las simulaciones hemos podido observar lo siguiente:

· El atributo vida es muy débil, y en este modelo no compensa gastar puntos en dicho atributo.

· Los atributos “Daño” y “Cadencia” están muy igualados.

· Crítico es aparentemente débil contra “Daño” y “Cadencia”. No obstante, esa desigualdad es matemática. El atributo “Crítico” ofrece una característica aleatoria al modelo, y puede ser de gran ayuda si se combina con atributos como “Daño” y “Cadencia” de manera apropiada. La clave de las partidas será cómo jugamos con la combinación de esas variables.



##Partidas reales

A continuación crearemos tres equipos (Juan, Jordi, y Ignasi) repartiendo un máximo de 10 puntos entre todos los atributos. Cada equipo pondrá los atributos como crea que sean óptimos, y se realizarán partidas para ver qué combinación de las tres es la más eficaz.

Equipos:


		Juan		Jordi		Ignasi
Vida		100 (Value: 1)	100 (Value: 1)	100 (Value: 1)
Daño		4 (Value: 4)	3 (Value: 3)	2 (Value: 2)
Crítico		3 ( Value: 4)	0 (Value: 1)	1 (Value: 2)
Cadencia	1 ( Value: 1)	5 (Value: 5)	5 (Value: 5)




Partida 1



		Juan		Ignasi
Vida		100		100
Daño		4		2
Crítico		3		1
Cadencia	1		5

Empate: Situación muy curiosa.

Al inicio parece que el equipo “Ignasi” domina el encuentro. No obstante, se llega a un punto en el que la posición en la que se encuentra con los minions de Juan da una ventaja posicional a la torre, y elimina a todos los minions Ignasi antes de que estos puedan dañarla. La partida no termina nunca. Establecemos el empate.

Partida 2


		Juan		Jordi
Vida		100		100
Daño		4		3
Crítico		3		0
Cadencia	1		5

Ganador: Jordi

Jordi ha dominado desde el inicio el encuentro y ha aplastado a Juan brutalmente.


Partida 3



		Ignasi		Jordi
Vida		100		100
Daño		2		3
Crítico		1		0
Cadencia	5		5

Ganador: Empate



Partida infinita. Equipos muy equilibrados.

A continuación repetiremos las partidas empatadas, y, a modo de desempate, disminuimos el daño de las torres a 1, para observar el más explícitamente el comportamiento de los minions y la configuración de sus atributos:

Partida 1.1 (Daño de torres a 1)

		Juan		Ignasi
Vida		100		100
Daño		4		2
Crítico		3		1
Cadencia	1		5

Ganador: Ignasi

Después de modificar el daño de las torres, el equipo “Juan” ha tenido poco que hacer frente a los 5 puntos de “Cadencia” del equipo “Ignasi”

Partida 3.1 (Daño de torres a 1)

		Ignasi		Jordi
Vida		100		100
Daño		2		3
Crítico		1		0
Cadencia	5		5

Ganador: Jordi

El arriesgado punto de Crítico del equipo de Ignasi no ha sido suficiente contra la inversión de Jordi en el punto más de Daño.


##Conclusiones Finales

El equipo más con más éxito ha sido “Jordi”.

Después de observar los resultados de las partidas reales, podemos concluir que el atributo en el que más vale la pena invertir puntos es “Cadencia” seguido de “Daño”, “Crítico” y “Vida”.

Se observa que estas conclusiones coinciden con las conclusiones de los experimentos. No obstante, pensábamos que el crítico iba a jugar un papel más importante en las simulaciones y en las partidas. Quizá una manera de dar más importancia al “Crítico” sería modificar el modelo y establecer un valor más alto de “Daño Adicional” cada vez que se ejecuta un golpe de estas características.


La combinación más eficaz de la simulación ha sido la siguiente:

		Jordi
Vida		100
Daño		3
Crítico		0
Cadencia	5


## CREDITS AND REFERENCES

Ignasi Ibáñez
Jordi Humet
Juan Avendaño

Trabajo practico de Simulación, modelaje y optmización.
Profesora: Marcela Castro.
Escoles universitaries Gimbernat i Tomàs Cerdà. GNU 2016.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -2064490 true false 45 165 120
Circle -2064490 true false 135 165 120
Rectangle -2064490 true false 105 60 195 210
Circle -2064490 true false 105 15 90
Line -16777216 false 195 60 90 60
Line -16777216 false 150 15 150 30
Line -16777216 false 75 195 30 195
Line -16777216 false 60 210 60 240
Line -16777216 false 105 240 75 255
Line -16777216 false 75 240 60 270
Line -16777216 false 90 255 90 285
Line -16777216 false 105 210 75 210
Line -16777216 false 135 225 120 270
Line -16777216 false 195 180 225 195
Line -16777216 false 195 210 195 255

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

nexo
false
0
Polygon -7500403 true true 150 45 15 150 75 270 225 270 285 150
Polygon -7500403 true true 150 255 285 150 225 30 75 30 15 150

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.3.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

dgfbdfgb
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
