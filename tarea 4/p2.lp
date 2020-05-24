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
% 2) Cada columna del tablero contiene, exactamente, 2 fichas.
% 3) Tanto la diagonal principal como la secundaria están vacías.
% 4) La primera y la última fila del tablero presentan la misma configuración (i.e. contienen fichas en exactamente las mismas posiciones).

% Posicionar fichas para la primera y ultima fila de acuerdo a R4
2{p(1, Y) : celdas_disponibles(1, Y)}2.
2{p(n, Y) : p(1, Y)}2.

% Generar todas las combinaciones para las columnas, excluyendo las ya definidas.
% 2{q(X, Y) : celdas_disponibles(X, Y), not p(X, Y)}.

% Tomar solo 2 por cada Y.
% 2{p(X, Y) : q(X, Y)}2 :- X=2..(n - 1).

1{p(X, Y) : celdas_disponibles(X, Y), Y=1..n}n:- X=1..n.
% :- p(X, Y), P(X - 1, Y).
% p(X, Y):- celdas_disponibles(X, Y), not p(1, X), X=2..(n-1).

% Definicion de los espacios no ocupables (libres)
diagonal_p(X, Y):- X=1..n, Y=X.
diagonal_s(X, Y):- X=1..n, Y=(n + 1) - X.

diagonal_vacia(X, Y):- diagonal_p(X, Y).
diagonal_vacia(X, Y):- diagonal_s(X, Y).

celdas_disponibles(X, Y):- X=1..n,Y=1..n, not diagonal_vacia(X, Y).


% #show fichas_filas/2.
% #show fichas_columnas/2.

#show p/2.
% Para la primera fila 
% fichas_defecto(X, Y):- celdas_disponibles(X, Y), X=1, Y=2..(n - 1).

% Para la ultima fila
% fichas_defecto(X, Y):- celdas_disponibles(X, Y), X=5, Y=2..(n - 1).

% Se generan las fichas alternativas, tomando en cuenta el enunciado 2, donde se tiene exactamente dos por columnas y las columnas donde NO se tienen fichas, por lo que denomino alternativas, son la primera y la última columna.

% fa(2..n-1).
% 2{fichas_alternativas(1,Y) : fa(Y)}2.
% 2{fichas_alternativas(n,Y) : fa(Y)}2.

%  Para conocer el resultado final, pues se muestran las fichas posicionadas por defecto, dígase las de la primera y última fila, más la de la primera y última columna.
% p(X, Y):- fichas_defecto(X, Y).
% p(X, Y):- fichas_alternativas(X, Y).

% #show fichas_defecto/2.
% #show fichas_alternativas/2.

% #show p/2.
% #show ficha_en_fila/2.
%*
B) Describe una solución, si es que la hay, para N=5.

Teniendo un valior de cinco para n se tiene 9 soluciones posibles, así lo muestra la salida siguiente.

$ clingo p2.lp 0 --quiet  -c n=5
clingo version 4.5.4
Reading from p2.lp
Solving...
SATISFIABLE

Models       : 9
Calls        : 1
Time         : 0.003s (Solving: 0.00s 1st Model: 0.00s Unsat: 0.00s)
CPU Time     : 0.000s

C) ¿Cuántas soluciones distintas hay para N=8?

Para un n con valor de ocho se tiene unas 225 posibles soluciones como explicia la salida debajo.

$ clingo p2.lp 0 --quiet -c n=8
clingo version 4.5.4
Reading from p2.lp
Solving...
SATISFIABLE

Models       : 225
Calls        : 1
Time         : 0.004s (Solving: 0.00s 1st Model: 0.00s Unsat: 0.00s)
CPU Time     : 0.016s
*%