% ---------------------------------------------
% MULCIA. Teoría de Modelos 2019-2020
% ---------------------------------------------
% TAREA 2
% ----------------------------------------------
% Fecha de entrega: 13 de abril de 2020
% Enviar por correo electrónico a: acordon@us.es
% Formato solución: libre (txt, pdf, foto, ...)
% ---------------------------------------------
% EJERCICIO 1
% ---------------------------------------------
% Se considera la siguiente signatura:
% Objetos={a,b,c,d,e,mesa}
% Relaciones={bloque/1,ubicacion/1,sobre/2,encima/2,mismaPila/2,rojo/1,verde/1,azul/1}

% A) Escribe un programa ASP *positivo* que capture la información de la siguiente base de conocimiento:

% 1) a,b,c,d,e,f son bloques.
bloque(a).
bloque(b).
bloque(c).
bloque(d).
bloque(e).
bloque(f).

% 2) a está sobre b, b está sobre c, c está sobre d y d está sobre la mesa.
sobre(a, b).
sobre(b, c).
sobre(c, d).
sobre(d, mesa).

% 3) e está sobre f y f está sobre la mesa.
sobre(e, f).
sobre(f, a).

% 4) La mesa es una ubicación y cualquier bloque que tengamos en la base de conocimiento es también una ubicación.
ubicacion(mesa).
ublicacion(X):- bloque(X).

% 5) encima(X,Y) se verifica si X está inmediatamente sobre Y o bien X está sobre un bloque Z que, a su vez, está encima de Y.
% (En nuestro ejemplo particular, el bloque b está encima de la mesa aunque b no está sobre la mesa).
encima(X, Y):- sobre(X, Y).
encima(X, Z):- sobre(X, Z), encima(Z, Y).

% 6) mismaPila(X,Y) se verifica si X e Y son bloques que están apilados en la misma pila.
mismaPila(X, Y):- bloque(X), bloque(Y), encima(X, Y).

% 7) Cada bloque es o bien rojo, o bien verde, o bien azul.
bloque(X):- rojo(X) ; azul(X) ; verde(X).

% 8) Todos los bloques que están apilados en la misma pila son del mismo color.
rojo(X):- mismaPila(X, Y), rojo(Y).
azul(X):- mismaPila(X, Y), azul(Y).
verde(X):- mismaPila(X, Y), verde(Y).


% B) Apelando a la intuición, describe cuáles deberían ser los conjuntos de respuestas del programa (incluye una breve justificación).

% RESPUESTA {
%   bloque(a).
%   bloque(b).
%   bloque(c).
%   bloque(d).
%   bloque(e).
%   bloque(f).

%   sobre(a, b).
%   sobre(b, c).
%   sobre(c, d).
%   sobre(d, mesa).
%   sobre(e, f).
%   sobre(f, mesa).

%   ubicacion(a).
%   ubicacion(b).
%   ubicacion(c).
%   ubicacion(d).
%   ubicacion(e).
%   ubicacion(f).
%   ubicacion(mesa).

%   encima(a, b).
%   encima(b, c).
%   encima(c, d).
%   encima(d, e).
%   encima(e, f).
%   encima(f, mesa).

%   mismaPila(a, b).
%   mismaPila(b, c).
%   mismaPila(c, d).
%   mismaPila(d, e).
%   mismaPila(e, f).
%   mismaPila(f, mesa).

% }

% JUSTIFICACION: Fui comprobando cada bloque de arriba hacia abajo a partir de lo ya conocido, para la parte final de los colores, pues tomé uno arbitratiamente.

% C) Comprueba con CLINGO si, de hecho, esos son los conjuntos de respuestas del programa.

% CONJUNTO DE RESPUESTA: 1
% bloque(a) bloque(b) bloque(c) bloque(d) bloque(e) bloque(f) ublicacion(a) ublicacion(b) ublicacion(c) ublicacion(d) ublicacion(e) ublicacion(f) sobre(a,b) sobre(b,c) sobre(c,d) sobre(d,mesa) sobre(e,f) sobre(f,mesa) encima(a,b) encima(b,c) encima(c,d) encima(d,mesa) encima(e,f) encima(f,mesa) mismaPila(a,b) mismaPila(b,c) mismaPila(c,d) mismaPila(e,f) ubicacion(mesa) rojo(a) rojo(b) rojo(c) rojo(d) rojo(e) rojo(f)

% CONJUNTO DE RESPUESTA: 2
% bloque(a) bloque(b) bloque(c) bloque(d) bloque(e) bloque(f) ublicacion(a) ublicacion(b) ublicacion(c) ublicacion(d) ublicacion(e) ublicacion(f) sobre(a,b) sobre(b,c) sobre(c,d) sobre(d,mesa) sobre(e,f) sobre(f,mesa) encima(a,b) encima(b,c) encima(c,d) encima(d,mesa) encima(e,f) encima(f,mesa) mismaPila(a,b) mismaPila(b,c) mismaPila(c,d) mismaPila(e,f) ubicacion(mesa) rojo(a) rojo(b) rojo(c) rojo(d) verde(e) verde(f)

% CONJUNTO DE RESPUESTA: 3
% bloque(a) bloque(b) bloque(c) bloque(d) bloque(e) bloque(f) ublicacion(a) ublicacion(b) ublicacion(c) ublicacion(d) ublicacion(e) ublicacion(f) sobre(a,b) sobre(b,c) sobre(c,d) sobre(d,mesa) sobre(e,f) sobre(f,mesa) encima(a,b) encima(b,c) encima(c,d) encima(d,mesa) encima(e,f) encima(f,mesa) mismaPila(a,b) mismaPila(b,c) mismaPila(c,d) mismaPila(e,f) ubicacion(mesa) rojo(a) rojo(b) rojo(c) rojo(d) azul(e) azul(f)

% CONJUNTO DE RESPUESTA: 4
% bloque(a) bloque(b) bloque(c) bloque(d) bloque(e) bloque(f) ublicacion(a) ublicacion(b) ublicacion(c) ublicacion(d) ublicacion(e) ublicacion(f) sobre(a,b) sobre(b,c) sobre(c,d) sobre(d,mesa) sobre(e,f) sobre(f,mesa) encima(a,b) encima(b,c) encima(c,d) encima(d,mesa) encima(e,f) encima(f,mesa) mismaPila(a,b) mismaPila(b,c) mismaPila(c,d) mismaPila(e,f) ubicacion(mesa) verde(a) verde(b) verde(c) verde(d) azul(e) azul(f)

% CONJUNTO DE RESPUESTA: 5
% bloque(a) bloque(b) bloque(c) bloque(d) bloque(e) bloque(f) ublicacion(a) ublicacion(b) ublicacion(c) ublicacion(d) ublicacion(e) ublicacion(f) sobre(a,b) sobre(b,c) sobre(c,d) sobre(d,mesa) sobre(e,f) sobre(f,mesa) encima(a,b) encima(b,c) encima(c,d) encima(d,mesa) encima(e,f) encima(f,mesa) mismaPila(a,b) mismaPila(b,c) mismaPila(c,d) mismaPila(e,f) ubicacion(mesa) verde(a) verde(b) verde(c) verde(d) verde(e) verde(f)

% CONJUNTO DE RESPUESTA: 6
% bloque(a) bloque(b) bloque(c) bloque(d) bloque(e) bloque(f) ublicacion(a) ublicacion(b) ublicacion(c) ublicacion(d) ublicacion(e) ublicacion(f) sobre(a,b) sobre(b,c) sobre(c,d) sobre(d,mesa) sobre(e,f) sobre(f,mesa) encima(a,b) encima(b,c) encima(c,d) encima(d,mesa) encima(e,f) encima(f,mesa) mismaPila(a,b) mismaPila(b,c) mismaPila(c,d) mismaPila(e,f) ubicacion(mesa) verde(a) verde(b) verde(c) verde(d) rojo(e) rojo(f)

% CONJUNTO DE RESPUESTA: 7
% bloque(a) bloque(b) bloque(c) bloque(d) bloque(e) bloque(f) ublicacion(a) ublicacion(b) ublicacion(c) ublicacion(d) ublicacion(e) ublicacion(f) sobre(a,b) sobre(b,c) sobre(c,d) sobre(d,mesa) sobre(e,f) sobre(f,mesa) encima(a,b) encima(b,c) encima(c,d) encima(d,mesa) encima(e,f) encima(f,mesa) mismaPila(a,b) mismaPila(b,c) mismaPila(c,d) mismaPila(e,f) ubicacion(mesa) azul(a) azul(b) azul(c) azul(d) azul(e) azul(f)

% CONJUNTO DE RESPUESTA: 8
% bloque(a) bloque(b) bloque(c) bloque(d) bloque(e) bloque(f) ublicacion(a) ublicacion(b) ublicacion(c) ublicacion(d) ublicacion(e) ublicacion(f) sobre(a,b) sobre(b,c) sobre(c,d) sobre(d,mesa) sobre(e,f) sobre(f,mesa) encima(a,b) encima(b,c) encima(c,d) encima(d,mesa) encima(e,f) encima(f,mesa) mismaPila(a,b) mismaPila(b,c) mismaPila(c,d) mismaPila(e,f) ubicacion(mesa) azul(a) azul(b) azul(c) azul(d) verde(e) verde(f)

% CONJUNTO DE RESPUESTA: 9
% bloque(a) bloque(b) bloque(c) bloque(d) bloque(e) bloque(f) ublicacion(a) ublicacion(b) ublicacion(c) ublicacion(d) ublicacion(e) ublicacion(f) sobre(a,b) sobre(b,c) sobre(c,d) sobre(d,mesa) sobre(e,f) sobre(f,mesa) encima(a,b) encima(b,c) encima(c,d) encima(d,mesa) encima(e,f) encima(f,mesa) mismaPila(a,b) mismaPila(b,c) mismaPila(c,d) mismaPila(e,f) ubicacion(mesa) azul(a) azul(b) azul(c) azul(d) rojo(e) rojo(f)


% D) Propón una nueva configuración de los bloques modificando solo los hechos en A.3) de manera que el programa resultante tenga, exactamente, tres conjuntos de respuestas.

% sobre(e, f).
% sobre(f, a).
