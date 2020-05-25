%*
---------------------------------------------
EJERCICIO 1
---------------------------------------------
Considera la siguiente información.
Los adultos normalmente trabajan. Los niños no trabajan en ningún caso.
Los estudiantes son adultos que pueden trabajar o no.
Los desempleados son adultos que no trabajan en ningún caso.
Los jubilados son adultos que, por regla general, no trabajan.
Ahora bien, los jubilados nacidos en Aragón pueden obtener un permiso especial de su Comunidad Autónoma que les permite trabajar.
Juan y Berta son adultos no estudiantes. Juan no trabaja.
Kate y Jim son estudiantes. Kate trabaja.
Pedro está desempleado.
Fede está jubilada y nació en Galicia.
Norberto está jubilado y nació en Aragón.
María es una preciosa niña.
*%

% A) Usando la representación de las reglas de razonamiento por defecto estudiada en la clase del 6 de mayo, escribe un programa ASP que capture esta información.

% Los adultos normalmente trabajan. Los niños no trabajan en ningún caso.
trabaja(X):- adulto(X), not desempleado(X).
-trabaja(X):- infante(X).

% Los estudiantes son adultos que pueden trabajar o no.
adulto(X):- estudiante(X).

% Los desempleados son adultos que no trabajan en ningún caso.
desempleado(X):- adulto(X), -trabaja(X).

% Los jubilados son adultos que, por regla general, no trabajan.
adulto(X):- jubilado(X).

-trabaja(X):- jubilado(X), not ab(jubilado(X)).

% Ahora bien, los jubilados nacidos en Aragón pueden obtener un permiso especial de su Comunidad Autónoma que les permite trabajar.
ab(jubilado(X)):- nacido_en(aragon, X), trabaja(X).

% Juan y Berta son adultos no estudiantes. Juan no trabaja.
adulto(berta).

-estudiante(juan).
-estudiante(berta).

desempleado(juan).

% Kate y Jim son estudiantes. Kate trabaja.
estudiante(kate).
estudiante(jim).

desempleado(kate).

% Pedro está desempleado.
desempleado(pedro).

% Fede está jubilada y nació en Galicia.
jubilado(fede).
nacido_en(galicia, fede).

% Norberto está jubilado y nació en Aragón.
jubilado(norberto).
nacido_en(aragon, norberto).

% DESCOMENTAR ESTO PARA CONFIRMAR SI TRABAJA O NO NORBERTO.

% trabaja(norberto).

% María es una preciosa niña.
infante(maria).

% B) De acuerdo al programa, ¿qué personas trabajan y cuáles no?
#show trabaja/1.
#show desempleado/1.

%*
C) Supongamos ahora que tenemos información completa sobre los predicados
"ser desempleado" y "ser jubilado" (es decir, si un adulto es desempleado o jubilado, aparece explícitamente en nuestra base de datos).
Añade reglas que modelen esta hipótesis. ¿Qué responde ahora el programa sobre qué personas trabajan y cuáles no?
-----------------------------------------------------------------
*%

% #show desempleado/1.

%*
Para este problema nos da dos posibles soluciones, donde puede que trabaje o no Norberto pues no tenemos constancia de si tiene un permiso especial o no. Es algo que desconoce la base de conocimientos hasta el momento. Sin embargo, si se explicíta que tiene o no trabajo, pues la respuesta es una sola.

$ clingo 0 p1.lp 
clingo version 4.5.4
Reading from p1.lp
Solving...
Answer: 1
desempleado(juan) desempleado(kate) desempleado(pedro) desempleado(fede) desempleado(norberto) trabaja(berta) trabaja(jim)
Answer: 2
desempleado(juan) desempleado(kate) desempleado(pedro) desempleado(fede) trabaja(berta) trabaja(jim) trabaja(norberto)
SATISFIABLE

Models       : 2
Calls        : 1
Time         : 0.026s (Solving: 0.02s 1st Model: 0.00s Unsat: 0.01s)
CPU Time     : 0.000s
*%