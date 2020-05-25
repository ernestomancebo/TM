%*
-------------------------------------------------------------
EJERCICIO 2
--------------------------------------------------------------
Se considera un tablero de tamaño NxN. Se desea colocar fichas en el tablero de acuerdo a las siguientes reglas.
1) Cada fila del tablero contiene, exactamente, 2 fichas.
2) Cada columna del tablero contiene, exactamente, 2 fichas.
3) Tanto la diagonal principal como la secundaria están vacías.
4) La primera y la última fila del tablero presentan la misma configuración (i.e. contienen fichas en exactamente las mismas posiciones).
*%

% A) Escribe un programa ASP que genere una solución del problema anterior.
% Nota: Usa el predicado binario p/2 con el significado p(X,Y) = hay una ficha en la fila X, columna Y del tablero.

#const n=5.

% 1) Cada fila del tablero contiene, exactamente, 2 fichas.
2{p(X, Y) : Y=1..n}2:- X=1..n.

% 2) Cada columna del tablero contiene, exactamente, 2 fichas.
2{p(X, Y) : X=1..n}2:- Y=1..n.

% 3) Tanto la diagonal principal como la secundaria están vacías.
-p(X, Y):- X=1..n, Y=X.
-p(X, Y):- X=1..n, Y=(n + 1) - X.

% 4) La primera y la última fila del tablero presentan la misma configuración (i.e. contienen fichas en exactamente las mismas posiciones).
p(n, X):- p(1, X).

#show p/2.

%*
B) Describe una solución, si es que la hay, para N=5.

Teniendo un valior de cinco para n se tiene 2 soluciones posibles, así lo muestra la salida siguiente.

$ clingo 0 p2.lp 
clingo version 4.5.4
Reading from p2.lp
Solving...
Answer: 1
p(5,2) p(1,2) p(5,4) p(1,4) p(2,3) p(2,5) p(3,1) p(3,5) p(4,1) p(4,3)   
Answer: 2
p(5,2) p(1,2) p(5,4) p(1,4) p(2,1) p(2,3) p(3,1) p(3,5) p(4,3) p(4,5)   
SATISFIABLE

Models       : 2
Calls        : 1
Time         : 0.037s (Solving: 0.03s 1st Model: 0.00s Unsat: 0.02s)
CPU Time     : 0.016s

C) ¿Cuántas soluciones distintas hay para N=8?

Para un n con valor de ocho se tiene unas 34089 posibles soluciones como explicia la salida debajo.

$ clingo 0 p2.lp -c n=8 --quiet
clingo version 4.5.4
Reading from p2.lp
Solving...
SATISFIABLE

Models       : 34089
Calls        : 1
Time         : 0.064s (Solving: 0.06s 1st Model: 0.01s Unsat: 0.00s)
CPU Time     : 0.078s
*%