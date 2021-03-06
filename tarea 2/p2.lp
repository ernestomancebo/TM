% ---------------------------------------------
% EJERCICIO 2
% ---------------------------------------------
% Sea P2 el programa *normal*

pajaro(a).
pajaro(b).
pajaro(c).
avestruz(b).
avestruz(c).
rosa(c).
vuela(X) :- pajaro(X), not excepcion(X), not enfermo(X).
excepcion(X) :- pinguino(X).
excepcion(X) :- avestruz(X), not especial(X).
vuela(X) :- avestruz(X), especial(X).
especial(X) :- pajaro(X), rosa(X).
gris(X) :- pajaro(X), not rosa(X).

%* A) Da una función de nivel para P2 que demuestre que P2 es un programa localmente estratificado.

pajaro(a).                                               %H1
pajaro(b).                                               %H2
pajaro(c).                                               %H3
avestruz(b).                                             %H4
avestruz(c).                                             %H5
rosa(c).                                                 %H6
excepcion(b) :- avestruz(b), not especial(b).            %R1
vuela(a) :- pajaro(a), not excepcion(a), not enfermo(a). %R2
vuela(c) :- avestruz(c), especial(c).                    %R3
especial(c) :- pajaro(c), rosa(c).                       %R4
gris(a) :- pajaro(a), not rosa(a).                       %R5
gris(b) :- pajaro(b), not rosa(b).                       %R6

Atomos(P2) = { pajaro(a), pajaro(b), pajaro(c), avestruz(b), avestruz(c), rosa(c), excepcion(b), especial(b), vuela(a), excepcion(a), enfermo(a), vuela(c), especial(c), gris(a), rosa(a), gris(b), rosa(b) }

||pajaro(a)||   =V1  ||pajaro(b)||  =V2  ||pajaro(c)||=V3
||avestruz(b)|| =V4  ||avestruz(c)||=V5  ||rosa(c)||  =V6
||excepcion(b)||=V7  ||especial(b)||=V8  ||vuela(a)|| =V9
||excepcion(a)||=V10 ||enfermo(a)|| =V11 ||vuela(c)|| =V12
||especial(c)|| =V13 ||gris(a)||    =V14 ||rosa(a)||  =V15
||gris(b)||     =V16 ||rosa(b)||    =V17

Obtenemos un sistema de inecuaciones aplicando la Definición 4:

Por R1: V8 <= V7 && V4 < V7
Por R2: V11 <= V9 && V10 <= V9 && V1 < V9
Por R3: V13 <= V12 && V5 < V12
Por R4: V6 <= V13 && V3 < V13
Por R5: V15 <= V14 && V1 < V14
Por R6: V17 <= V16 && V2 < V16

V1=V2=V3=V4=V5=V6=0 (pajaro(a), pajaro(b), pajaro(c), avestruz(b), avestruz(c), rosa(c) no aparecen en la cabeza de ninguna regla que no sea un hecho)
V8=V10=V11=V15=V17=0 (especial(b), excepcion(a), enfermo(a), rosa(a), rosa(b) no aparecen en la cabeza de ninguna regla)
V7=V9=V13=V14=V16=1 (Para satisfacer R1, R2, R4, R5 y R6)
V12=2 (Para satisfacer R3)

Luego, la siguiente función de nivel para P2

||pajaro(a)||   =0 ||pajaro(b)||  =0 ||pajaro(c)||=0
||avestruz(b)|| =0 ||avestruz(c)||=0 ||rosa(c)||  =0
||excepcion(b)||=1 ||especial(b)||=0 ||vuela(a)|| =1
||excepcion(a)||=0 ||enfermo(a)|| =0 ||vuela(c)|| =2
||especial(c)|| =1 ||gris(a)||    =1 ||rosa(a)||  =0
||gris(b)||     =1 ||rosa(b)||    =0

Esto nos permite demostrar que P2 es localmente estratificado. Puesto que en este programa no aparece la disyunción epistémica(;), por la Proposición 2 inferimos que es consistente y tiene un único conjunto de respuestas el cual es:

Answer: 1
pajaro(a) pajaro(b) pajaro(c) excepcion(b) vuela(c) vuela(a) avestruz(b) avestruz(c) especial(c) rosa(c) gris(a) gris(b)
SATISFIABLE
*%

% B) Justifica que P2 tiene exactamente un conjunto de respuestas.

% RESPUESTA: P2 tiene exactamente un conjunto de respuesta, pues no contiene disyunción epistémica alguna.

% C) Apelando a la intuición, describe cuál debería ser dicho conjunto de respuestas (incluye una breve justificación).

%*
CONJUNTO DE RESPUESTA: { 
    pajaro(a)
    pajaro(b)
    pajaro(c)
    avestruz(b)
    avestruz(c)
    rosa(c)
    vuela(a)
    excepcion(b)
    vuela(c)
    especial(c)
    gris(a)
    gris(b)
 }

JUSTIFICACION: Tomé como punto de partida primero los hechos, posteriormente fui evaluando inversamente desde la última regla (gris(X)) hacia atrás.
*%

% D) Comprueba con CLINGO cuál es el único conjunto de respuestas de P2.

% pajaro(a) pajaro(b) pajaro(c) excepcion(b) vuela(c) vuela(a) avestruz(b) avestruz(c) especial(c) rosa(c) gris(a) gris(b)

% ------------------------------------------------------------------