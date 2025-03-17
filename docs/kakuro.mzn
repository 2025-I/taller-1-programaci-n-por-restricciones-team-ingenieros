% Kakuro en MiniZinc usando la estrategia First-Fail

% Parámetros
int: n;                                    % Tamaño de la cuadrícula (n x n)
array[1..n, 1..n] of 0..1: validCell;      % 1 si la celda puede tener un número, 0 si es una pared
array[1..n, 1..n] of 0..45: hsum;          % Pistas de suma horizontal (0 si no hay pista)
array[1..n, 1..n] of 0..45: vsum;          % Pistas de suma vertical (0 si no hay pista)

% Variables de decisión
array[1..n, 1..n] of var 0..9: grid;       % La cuadrícula completada (0 para paredes)

% Importar la biblioteca necesaria para la restricción all_different
include "globals.mzn";

% Restricciones
% 1. Paredes y celdas válidas
constraint forall(i in 1..n, j in 1..n) (
  if validCell[i,j] == 0 then
    grid[i,j] = 0                         % Las paredes son 0
  else
    grid[i,j] >= 1 /\ grid[i,j] <= 9      % Las celdas válidas deben estar entre 1 y 9
  endif
);

% 2. Sumas horizontales y unicidad
constraint forall(i in 1..n, j in 1..n) (
  if hsum[i,j] > 0 then
    let {
      % Encontrar todas las celdas a la derecha que sean válidas
      array[int] of int: cells = [ k | k in j+1..n where validCell[i,k] == 1 ];
    } in (
      if length(cells) > 0 then
        sum(k in cells) (grid[i,k]) == hsum[i,j] /\
        all_different([grid[i,k] | k in cells where grid[i,k] > 0])
      else
        true
      endif
    )
  else
    true
  endif
);

% 3. Sumas verticales y unicidad
constraint forall(i in 1..n, j in 1..n) (
  if vsum[i,j] > 0 then
    let {
      % Encontrar todas las celdas debajo que sean válidas
      array[int] of int: cells = [ k | k in i+1..n where validCell[k,j] == 1 ];
    } in (
      if length(cells) > 0 then
        sum(k in cells) (grid[k,j]) == vsum[i,j] /\
        all_different([grid[k,j] | k in cells where grid[k,j] > 0])
      else
        true
      endif
    )
  else
    true
  endif
);

% Resolver usando la estrategia First-Fail
solve :: int_search([grid[i,j] | i in 1..n, j in 1..n], first_fail, indomain_min, complete) satisfy;

% Salida: Solo números
output [
  if j == 1 then "\n" else " " endif ++
  if fix(grid[i,j]) == 0 then " " else show(grid[i,j]) endif
  | i in 1..n, j in 1..n
];
