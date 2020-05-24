%*
---------------------------------------------
EJERCICIO 2
---------------------------------------------
Se considera la siguiente base de conocimiento.

Los aviones, los pájaros y los drones son objetos voladores.
Los aviones son más rápidos que los pájaros y que los drones.
Los aviones pueden ser de pasajeros o de carga.
Normalmente, los aviones son blancos aunque los de carga no tiene por qué.
Los aviones de carga se fabrican en Francia.
Normalmente, los halcones son pájaros más rápidos que los petirrojos.
Sin embargo, hay petirrojos especiales que son más rápidos que cualquier halcón.
SR71 es un avión fabricado en España.
WW56 es un avión negro.
Tor es un petirrojo.
Pit es un halcón.
*%

% A) Escribe un programa ASP para modelizar este escenario. Para ello, debes construir una jerarquía de objetos voladores.

% Los aviones, los pájaros y los drones son objetos voladores.
clase(avion).
clase(pajaro).
clase(dron).

% Los aviones son más rápidos que los pájaros y que los drones.
mas_rapido(X, Y):- miembro(X, avion), miembro(Y, pajaro).
mas_rapido(X, Y):- miembro(X, avion), miembro(Y, dron).

% Los aviones pueden ser de pasajeros o de carga.
clase(carga).
clase(pasajero).

es_subclase(carga, avion).
es_subclase(pasajero, avion).

subclase(C1, C2):- es_subclase(C1, C2).
subclase(C1, C2):- es_subclase(C1, C3), es_subclase(C3, C2).

miembro(X,C) :- es_un(X,C).
miembro(X,C) :- es_un(X,C1), subclase(C1,C).

% Normalmente, los aviones son blancos aunque los de carga no tiene por qué.
miembro(X, carga):- es_un(X, avion), color(C), color(X, C), C!=blanco.
-color(X,C2) :- color(C2), color(X, C1), C1!=C2.

color(blanco).
color(X, blanco):- es_un(X, avion), color(C1), not color(X, C1), C1!=blanco. 

% Los aviones de carga se fabrican en Francia.
fabricado_en(X, francia):- miembro(X, carga).

% Normalmente, los halcones son pájaros más rápidos que los petirrojos.
es_subclase(halcon, pajaro).
es_subclase(petirrojo, pajaro).

mas_rapido(X, Y):- miembro(X, halcon), miembro(Y, petirrojo).

% Sin embargo, hay petirrojos especiales que son más rápidos que cualquier halcón.
es_subclase(petirrojo_esp, petirrojo).
mas_rapido(petirrojo_esp, halcon).

% SR71 es un avión fabricado en España.
es_un(sr71, avion).
fabricado_en(sr71, espana).

% WW56 es un avión negro.
color(negro).
es_un(ww56, avion).
color(ww56, negro).

% Tor es un petirrojo.
es_un(tor, petirrojo).

% Pit es un halcón.
es_un(pit, halcon).

#show mas_rapido/2.
#show color/2.
#show miembro/2.

%*

$ clingo aviones.lp 
clingo version 4.5.4
Reading from aviones.lp
Solving...
Answer: 1
mas_rapido(petirrojo_esp,halcon) color(ww56,negro) miembro(sr71,avion) miembro(ww56,avion) miembro(tor,petirrojo) miembro(pit,halcon)
miembro(tor,pajaro) miembro(pit,pajaro) mas_rapido(sr71,tor) mas_rapido(ww56,tor) mas_rapido(sr71,pit) mas_rapido(ww56,pit) color(sr71,blanco)
miembro(ww56,carga) mas_rapido(pit,tor)
SATISFIABLE

Models       : 1
Calls        : 1
Time         : 0.617s (Solving: 0.61s 1st Model: 0.01s Unsat: 0.60s)
CPU Time     : 0.062s

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

B) ¿Qué responde el programa a las siguientes preguntas?

¿Es SR71 más rápido que Tor?
Sí, mas_rapido(sr71,tor)

¿Es Pit más rápido que Tor?
Sí, mas_rapido(pit,tor)

¿Es SR71 un avión blanco?
Sí, color(sr71,blanco)

¿Es WW56 un avión de carga?
Sí, miembro(ww56,carga)

¿Coinciden las respuestas del programa con las que daría un razonador aplicando el sentido común?
Sí
*%