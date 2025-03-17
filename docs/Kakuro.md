# 📌 Taller 1: Modelamiento de CSP

## **Modelado del Kakuro como CSP**

📅 **Fecha de entrega:** 17 de marzo de 2025  
👨‍💻 **Integrantes:** Joann Esteban Bedoya, Alejandro Mesa, Willian David Correa  
📂 **Repositorio:** [GitHub Classroom](https://classroom.github.com/a/agiyKqJx)

---

## 1️⃣ **Introducción**

El **Kakuro** es un rompecabezas lógico que consiste en rellenar una cuadrícula con números entre **1 y 9**, de manera que:

1. Cada **grupo horizontal o vertical** debe sumar un valor específico indicado en las pistas.
2. **No se pueden repetir números** dentro del mismo grupo.
3. Las celdas negras **actúan como separadores** y no pueden contener valores.

Este documento presenta el **modelado del Kakuro como un Problema de Satisfacción de Restricciones (CSP)**, su implementación en **MiniZinc**, y un análisis de distintas estrategias utilizadas para resolverlo.

---

## 2️⃣ **Modelado del Kakuro como CSP**

### **2.1 Definición del Problema**

El problema de Kakuro se modela como un **CSP (Constraint Satisfaction Problem)** de la siguiente manera:

- **Filas y columnas con pistas:** Cada grupo de celdas debe sumar exactamente el valor dado en la pista.
- **Sin repetición:** No se permite repetir valores dentro de un mismo grupo.
- **Celdas negras:** No contienen valores y separan los grupos.

### **2.2 Variables del Problema**

Cada celda `grid[i, j]` es una variable, donde:

- `i` representa la fila.
- `j` representa la columna.
- **Dominio:** `{1,2,3,4,5,6,7,8,9}` (solo en celdas válidas).

Se definen matrices adicionales:

- `validCell[i, j]`: Indica si una celda es válida (`1`) o una pared (`0`).
- `hsum[i, j]`: Valor de la suma que deben cumplir las celdas a la derecha.
- `vsum[i, j]`: Valor de la suma que deben cumplir las celdas hacia abajo.

## 3️⃣ **Implementación en MiniZinc**

Se implementó el modelo CSP en `kakuro.mzn`, considerando las restricciones mencionadas.

### **3.1 Archivos del Proyecto**

| **Archivo**                            | **Descripción**             |
| -------------------------------------- | --------------------------- |
| [`kakuro.mzn`](../docs/kakuro.mzn)     | Modelo MiniZinc del Kakuro. |
| [`kakuro01.dzn`](../docs/kakuro01.dzn) | Tablero **3×3**.            |
| [`kakuro02.dzn`](../docs/kakuro02.dzn) | Tablero **4×4**.            |
| [`kakuro03.dzn`](../docs/kakuro03.dzn) | Tablero **5×5**.            |

---

## 4️⃣ **Pruebas Realizadas con Diferentes Tableros**

Se realizaron pruebas con **tres instancias de Kakuro**, variando el tamaño del tablero y los valores de las pistas.

### **4.1 Prueba en Tablero 3×3 (`kakuro01.dzn`)**

🔹 **Tiempo de ejecución:**
![Velocidad 3x3](./ImagenesDocumentacion/kakuro01md.png)  
🔹 **Mejor estrategia aplicada:** _XX_  
📂 **Captura de ejecución:**  
![Prueba 3x3](./ImagenesDocumentacion/kakuro01.png)

---

### **4.2 Prueba en Tablero 4×4 (`kakuro02.dzn`)**

🔹 **Tiempo de ejecución:**
![Velocidad 4x4](./ImagenesDocumentacion/kakuro02md.png)

🔹 **Mejor estrategia aplicada:** _XX_  
📂 **Captura de ejecución:**  
![Prueba 4x4](./ImagenesDocumentacion/kakur02.png)

---

### **4.3 Prueba en Tablero 5×5 (`kakuro03.dzn`)**

🔹 **Tiempo de ejecución:**
![Velocidad 3x3](./ImagenesDocumentacion/kakuro03md.png)  
🔹 **Mejor estrategia aplicada:** _XX_  
📂 **Captura de ejecución:**  
![Prueba 5x5](./ImagenesDocumentacion/kakuro03.png)

---

## 5️⃣ **Comparación de Estrategias**

| **Estrategia**       | **Tiempo de ejecución (ms)** |
| -------------------- | ---------------------------- |
| **DFS**              | XX ms                        |
| **First Fail**       | XX ms                        |
| **Branch and Bound** | XX ms                        |

📌 **Conclusión:**

- La estrategia **`first_fail`** mostró la mejor eficiencia en términos de tiempo de ejecución.
- **Branch and Bound** puede mejorar algunos casos, pero su costo computacional es mayor.
- La búsqueda en profundidad (DFS) **es la menos eficiente**, aunque garantiza encontrar solución si existe.

---

## 6️⃣ **Pruebas Adicionales con la Estrategia `first_fail`**

Dado que la estrategia **`first_fail`** mostró los mejores resultados en términos de rendimiento, se realizaron **tres pruebas adicionales** con variaciones en los tableros para evaluar su estabilidad y efectividad.

Cada una de estas pruebas contiene **dos imágenes** que muestran los resultados obtenidos en diferentes ejecuciones.

### **6.1 Prueba Adicional 1**

📂 **Capturas de ejecución:**

- ![Prueba Adicional 1 - Resultado 1](./ImagenesDocumentacion/kakuro02prueba2.png)
- ![Prueba Adicional 1 - Resultado 2](./ImagenesDocumentacion/kakuro02prueba2ms.png)

---

### **6.2 Prueba Adicional 2**

📂 **Capturas de ejecución:**

- ![Prueba Adicional 2 - Resultado 1](./ImagenesDocumentacion/kakuro02prueba3.png)
- ![Prueba Adicional 2 - Resultado 2](./ImagenesDocumentacion/kakuro02prueba3ms.png)

---

### **6.3 Prueba Adicional 3**

📂 **Capturas de ejecución:**

- ![Prueba Adicional 3 - Resultado 1](../imagenes/kakuro_prueba_adicional3_1.png)
- ![Prueba Adicional 3 - Resultado 2](../imagenes/kakuro_prueba_adicional3_2.png)

---

📌 **Conclusión:**  
Los resultados obtenidos en estas pruebas adicionales confirman que la estrategia **`first_fail`** es eficiente en la mayoría de los casos, manteniendo tiempos de ejecución bajos y estabilidad en la resolución del Kakuro. Sin embargo, algunos casos requieren ajustes específicos en el modelo CSP para mejorar la optimización.

## 6️⃣ **Conclusiones**

✔ **Modelar Kakuro como CSP permite resolverlo de manera estructurada.**  
✔ **Se probaron tableros de distintos tamaños con MiniZinc.**  
✔ **Se deben comparar estrategias como `first_fail` y `branch and bound` para mejorar la solución.**

---

## 7️⃣ **Referencias**

🔗 **Wikipedia - Kakuro**: [https://en.wikipedia.org/wiki/Kakuro](https://en.wikipedia.org/wiki/Kakuro)  
🔗 **MiniZinc Documentation**: [https://www.minizinc.org/](https://www.minizinc.org/)
