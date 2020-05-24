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
tablero(X, Y):- X=1..n, Y=1..n.

% 2) Cada columna del tablero contiene, exactamente, 2 fichas.
ficha(X):- X=1..(n*2).

% #show ficha/1.

% 3) Tanto la diagonal principal como la secundaria están vacías.
diagonal_p(X, Y):- X=1..n, Y=X.
diagonal_s(X, Y):- X=1..n, Y=(n + 1) - X.

diagonal_vacia(X, Y):- diagonal_p(X, Y).
diagonal_vacia(X, Y):- diagonal_s(X, Y).

% #show diagonal_vacia/2.

% 4) La primera y la última fila del tablero presentan la misma configuración (i.e. contienen fichas en exactamente las mismas posiciones).
celdas_disponibles(X, Y):-X=1..n,Y=1..n, not diagonal_vacia(X, Y).

% #show celdas_disponible/2.

% Para la primera fila
fichas_defecto(X, Y):- celdas_disponibles(X, Y), X=1, Y=2..(n - 1).

% Para la ultima fila
fichas_defecto(X, Y):- celdas_disponibles(X, Y), X=5, Y=2..(n - 1).

% #show fichas_defecto/2.

% Para la columna 1
% fichas_alternativas(1, Y):- celdas_disponibles(1, Y), Y=(2..n-1).

% Para la columna n
% fichas_alternativas(n, Y):- celdas_disponibles(n, Y), Y=(2..n-1).

% #show fichas_alternativas/2.

fa(2..n-1).
2{fichas_alternativas(1,Y) : fa(Y)}2.
2{fichas_alternativas(n,Y) : fa(Y)}2.

% #show fichas_alternativas/2.

% posiciones_final(X, Y):- fichas_defecto(X, Y).
% posiciones_final(X, Y):- fichas_alternativas(X, Y).
% B) Describe una solución, si es que la hay, para N=5.

#show fichas_defecto/2.
#show fichas_alternativas/2.
% C) ¿Cuántas soluciones distintas hay para N=8?
