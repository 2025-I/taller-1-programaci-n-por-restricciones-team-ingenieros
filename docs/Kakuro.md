# 📌 Taller 1: Modelamiento de CSP

## **Modelado del Kakuro como CSP**

📅 **Fecha de entrega:** 17 de marzo de 2025  
👨‍💻 **Integrantes:** [Nombre1], [Nombre2], [Nombre3]  
📂 **Repositorio:** [GitHub Classroom](https://classroom.github.com/a/agiyKqJx)

---

## 1️⃣ **Introducción**

Kakuro es un rompecabezas numérico similar a un crucigrama en el que los números del 1 al 9 deben ser colocados en una cuadrícula sin repetirse en cada bloque, asegurando que la suma de los valores en un grupo sea igual al número indicado en la pista.

Este documento describe el **modelado de Kakuro como un Problema de Satisfacción de Restricciones (CSP)**, su implementación en **MiniZinc**, y un análisis de las diferentes estrategias utilizadas para resolverlo.

---

## 2️⃣ **Modelado del Kakuro como CSP**

### **2.1 Definición del Problema**

Cada celda de la cuadrícula puede contener un número entre 1 y 9, con las siguientes restricciones:

- **Suma de grupos:** La suma de los números en cada grupo horizontal y vertical debe ser igual a la pista dada.
- **No repetición:** No se pueden repetir números en un mismo grupo.
- **Celdas negras:** Representan pistas o separadores y no contienen valores.

### **2.2 Variables del Problema**

Cada celda blanca del tablero representa una variable `Xij`, donde:

- `i` representa la fila.
- `j` representa la columna.
- El dominio de cada celda es `{1,2,3,4,5,6,7,8,9}` si está en un grupo válido.

### **2.3 Restricciones del Modelo**

Las restricciones pueden expresarse como ecuaciones:

- **Restricción de suma:**  
  \[
  \forall \text{grupo } G, \quad \sum\_{X \in G} X = \text{pista}(G)
  \]
- **Restricción de no repetición:**  
  \[
  \forall \text{grupo } G, \quad \text{alldifferent}(X_1, X_2, ..., X_n)
  \]

---

## 3️⃣ **Implementación en MiniZinc**

El modelo CSP se implementó en `kakuro.mzn` y las pruebas se almacenaron en `kakuro.dzn`.

### **3.1 Código MiniZinc**

```minizinc
include "globals.mzn";
int: n; % Tamaño del tablero
array[1..n, 1..n] of var 0..9: grid;

% Restricciones de suma y no repetición en cada grupo
constraint forall(g in 1..num_grupos)(
    sum([grid[i, j] | (i, j) in grupo[g]]) = pista[g] /\
    alldifferent([grid[i, j] | (i, j) in grupo[g]])
);

solve satisfy;
```
