%*
---------------------------------------------
EJERCICIO 1
---------------------------------------------
El objetivo es usar un programa ASP para resolver el siguiente misterio.
(El Misterio del Asesinato de la Mansión Dreadsbury).
F1: Ágata, el mayordomo, Fedra y Carlos son los habitantes de la Mansión Dreadsbury.
F2: Alguien en la mansión Dreadsbury mató a la tía Ágata.
F3: Un asesino siempre odia a su víctima y no es más rico que su víctima.
F4: Carlos no odia a nadie que Ágata odie.
F5: Ágata odia a todo el mundo menos al mayordomo.
F6: El mayordomo odia a todos los que no son más ricos que la tía Ágata.
F7: El mayordomo odia a todos los que Ágata odia.
F8: Nadie odia a todo el mundo.
F9: Nadie es más rico que él o ella misma.
F10: La relación "ser más rico que" es transitiva.
F11: Fedra es más rica que Carlos y Carlos es más rico que Ágata.

¿Quién mató a Ágata?

A) Especifica las distintas constantes y los distintos predicados que usarás para formalizar el misterio.

Se considera la siguiente signatura:
Objetos={agata, mayordomo, fedra, carlos}
Relaciones={asesino/1, asesino/2, odia/2, mas_rico/2}

==========================================================================================

B) Escribe un programa ASP que represente el conocimiento expresado por cada una de las afirmaciones de F1 a F11.
*%

% F1: Ágata, el mayordomo, Fedra y Carlos son los habitantes de la Mansión Dreadsbury.
habitante(agata).
habitante(mayordomo).
habitante(fedra).
habitante(carlos).

% F2: Alguien en la mansión Dreadsbury mató a la tía Ágata.
asesino(X):- asesino(X, agata).

% F3: Un asesino siempre odia a su víctima y no es más rico que su víctima.
asesino(X, agata):- odia(X, agata), -mas_rico(X, agata).

% F4: Carlos no odia a nadie que Ágata odie.
-odia(carlos, Y):- habitante(Y), odia(agata, Y).

% F5: Ágata odia a todo el mundo menos al mayordomo.
odia(agata, Y):- habitante(Y), mayordomo!=Y.

% F6: El mayordomo odia a todos los que no son más ricos que la tía Ágata.
odia(mayordomo, Y):- habitante(Y), -mas_rico(Y, agata).

% F7: El mayordomo odia a todos los que Ágata odia.
odia(mayordomo, Y):- odia(agata, Y).

% F8: Nadie odia a todo el mundo.
-odia(X, Y):- habitante(X), habitante(Y), not odia(X, Y).

% F9: Nadie es más rico que él o ella misma.
-mas_rico(X, Y):- habitante(X), habitante(Y), Y==X.

% F10: La relación "ser más rico que" es transitiva.
mas_rico(X, Y):- mas_rico(X, Y).
mas_rico(X, Y):- mas_rico(X, Z), mas_rico(Z, Y).

% F11: Fedra es más rica que Carlos y Carlos es más rico que Ágata.
mas_rico(fedra, carlos).
mas_rico(carlos, agata).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                   BONUS
% 
% La regla debajo, aunque no dada por usted, establece que no es mas rico que Agata algun habitante que NO sepa que es más rico
% que Agata. Puede que esto viole la razón pues estoy asumiendo algo no provisto en el mandato. Me hubiese gustado aclarar esto
% durante alguna sesión de clases a fin de evitar una asumsión erronea, o en caso contrario, afirmar que es un hecho válido.
% 
% 
% El uso de esta regla hace que el resultado del programa arroje a Agata y al Mayordomo como asesino. Pues, da por hecho el que
% el Mayordomo no es mas rico que Agata pues no hay un hecho que afirme que lo es. Es un caso de "culpable hasta que se demuestre lo contrario".
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -mas_rico(X, agata):- habitante(X), not mas_rico(X, agata).

#show asesino/1.

%*
C) Responde a la pregunta "¿Quién mató a Ágata?" y describe la sesión CLINGO que has usado para ello.

C-1
La sesión utilizando los enunciados de F1 a F11 arroja como asesino de Agata a Agata misma.

$ clingo misterio_mansion.lp 
clingo version 4.5.4
Reading from misterio_mansion.lp
Solving...
Answer: 1
asesino(agata)
SATISFIABLE

Models       : 1     
Calls        : 1
Time         : 0.005s (Solving: 0.00s 1st Model: 0.00s Unsat: 0.00s)
CPU Time     : 0.000s

==========================================================================================

C-2
En caso de utilizar la regla Bonus descrita en la linea 71, nos da como posibles asesinos
tanto a Agata misma como el mayordomo, esto obedeciendo a F3 donde se observa lo siguiente:

* Agata: Ella no es mas rica que ella misma por F9, a la vez de no existe un hecho que explicitamente indique que ella no se odie a ella misma, mas se explicita
en F5 que ella odia a todo el mundo a excepción del mayordomo.

* Mayordomo: No existe un hecho que explicite que él sea más rico que Agata, a su vez de que en F6 se establece que él odia a todo el que no sea más rico que Agata,
perteneciendo Agata misma en ese subconjunto.

La sesión sería la siguiente:

$ clingo misterio_mansion.lp 
clingo version 4.5.4
Reading from misterio_mansion.lp
Solving...
Answer: 1
asesino(agata) asesino(mayordomo)
SATISFIABLE

Models       : 1
Calls        : 1
Time         : 0.016s (Solving: 0.02s 1st Model: 0.01s Unsat: 0.01s)
CPU Time     : 0.000s

==========================================================================================

D) ¿Es posible eliminar alguna de las afirmaciones de F1 a F11 de manera que el misterio siga teniendo la misma solución? Justifica tu respuesta.

Podemos suprimir a la afirmación F7, pues incluir en la base de conocimientos que el mayordomo odia a los que Agata odia no influye en la F3 la cual define
"quién es el asesino de Agata"; en otras lo que nos interesa es saber quién odia a Agata no a quienes Agata odia.
*%