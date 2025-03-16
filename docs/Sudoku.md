# 📌 Taller 1: Modelamiento de CSP

## **Modelado del Sudoku como CSP**

📅 **Fecha de entrega:** 17 de marzo de 2025  
👨‍💻 **Integrantes:** [Nombre1], [Nombre2], [Nombre3]  
📂 **Repositorio:** [GitHub Classroom](https://classroom.github.com/a/agiyKqJx)

---

## 1️⃣ **Introducción**

El Sudoku es un rompecabezas matemático de lógica en el que se deben llenar las casillas de una cuadrícula **9×9** con los números del 1 al 9, respetando ciertas restricciones.

Este documento presenta el **modelado del Sudoku como un Problema de Satisfacción de Restricciones (CSP)**, su implementación en **MiniZinc**, y un análisis de distintas estrategias utilizadas para resolverlo.

---

## 2️⃣ **Modelado del Sudoku como CSP**

### **2.1 Definición del Problema**

El Sudoku consiste en una cuadrícula de 9×9 donde se deben ubicar los números del 1 al 9 cumpliendo con estas restricciones:

- **Filas:** No puede haber números repetidos en la misma fila.
- **Columnas:** No puede haber números repetidos en la misma columna.
- **Subcuadrículas 3×3:** No puede haber números repetidos dentro de cada región de 3×3.

### **2.2 Variables del Problema**

Cada celda vacía del Sudoku representa una variable `Xij`, donde:

- `i` es la fila (`1 ≤ i ≤ 9`).
- `j` es la columna (`1 ≤ j ≤ 9`).
- El dominio de cada celda es `{1,2,3,4,5,6,7,8,9}`.

### **2.3 Restricciones del Modelo**

Las restricciones pueden expresarse como ecuaciones matemáticas:

- **Restricción de fila:**  
  \[
  \forall i \in [1,9], \quad \text{alldifferent}(X*{i,1}, X*{i,2}, ..., X\_{i,9})
  \]
- **Restricción de columna:**  
  \[
  \forall j \in [1,9], \quad \text{alldifferent}(X*{1,j}, X*{2,j}, ..., X\_{9,j})
  \]
- **Restricción de subcuadrículas 3×3:**  
  \[
  \forall B, \quad \text{alldifferent}(X*{b_1}, X*{b*2}, ..., X*{b_9})
  \]

---

## 3️⃣ **Implementación en MiniZinc**

Se implementó el modelo CSP en `sudoku.mzn`, considerando las restricciones y reglas del problema.

### **3.1 Código MiniZinc**

```minizinc
include "globals.mzn";
array[1..9, 1..9] of var 1..9: grid;

% Restricción de filas
constraint forall(i in 1..9) ( alldifferent([grid[i, j] | j in 1..9]));

% Restricción de columnas
constraint forall(j in 1..9) ( alldifferent([grid[i, j] | i in 1..9]));

% Restricción de subcuadrículas 3x3
constraint forall(i in 0..2, j in 0..2)
  (alldifferent([grid[3*i + di, 3*j + dj] | di in 1..3, dj in 1..3]));

solve satisfy;
```
