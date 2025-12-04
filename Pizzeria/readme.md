# Pizzería Don Piccolo – Base de Datos en MySQL

Este proyecto implementa una base de datos relacional diseñada para mejorar el control operativo de la pizzería Don Piccolo. El sistema permite gestionar pedidos, clientes, repartidores, inventario, pagos y procesos asociados a la entrega de domicilios, integrando funciones, triggers y vistas para optimizar las consultas y automatizar tareas críticas.

---

## Objetivo del Proyecto

Desarrollar una base de datos sólida, clara y funcional que centralice la información del negocio, automatice procesos comunes e integre mecanismos de control sobre inventario, pedidos y operaciones de entrega.

---

## Características Principales

- Registro y administración de clientes, repartidores, zonas y personal.  
- Gestión de pizzas, ingredientes y composición de productos.  
- Control de inventario mediante triggers automáticos.  
- Registro completo de pedidos, detalles, pagos y domicilios.  
- Funciones para cálculo del total de pedidos y ganancia neta diaria.  
- Procedimiento para actualizar automáticamente el estado de los pedidos.  
- Vistas de análisis operativo según los requerimientos del caso de estudio.

---

## Estructura de Archivos
```
pizzeriaPiccolo/
│
├── database.sql # Script de creación de la base de datos, tablas e inserción de datos
├── funciones.sql # Funciones del sistema: cálculos de totales e indicadores
├── triggers.sql # Triggers para control de inventario y actualización de estados
├── vistas.sql # Vistas solicitadas en el caso de estudio
├── consultas.sql # Consultas avanzadas requeridas por el sistema
└── README.md # Documento de referencia del proyecto
```

---

## Funciones Implementadas

### **1. fn_calcular_total_pedido(idPedido)**

Calcula el total final de un pedido considerando:

- Subtotal de pizzas  
- Costo del domicilio  
- Impuesto (IVA)  

El valor final es devuelto para uso en reportes y procesos internos.

---

### **2. fn_ganancia_neta(fecha)**

Retorna la ganancia neta de un día específico mediante:

- Ventas registradas  
- Costos generados por los ingredientes utilizados  

Permite obtener una visión clara de la rentabilidad diaria.

---

## Procedimientos

### **sp_marcar_pedido_entregado(idPedido)**

Actualiza el estado del pedido a *"entregado"* siempre que exista un domicilio con hora de entrega registrada. Automatiza el cierre del pedido de forma controlada y confiable.

---

## Triggers Implementados

### **1. Actualización de inventario**
Reduce automáticamente el stock de ingredientes cuando se agrega un detalle de pedido relacionado a una pizza.

### **2. Actualización automática del estado del pedido**
Cuando una entrega registra su hora de entrega, el sistema marca el pedido como *"entregado"*.

### **3. Auditoría de precios**
Registra cambios en los precios de pizzas en una tabla historial para control administrativo.

---

## Vistas Incluidas

### **1. Vista de resumen de pedidos por cliente**
Muestra la cantidad total de pedidos y el monto acumulado gastado por cliente.

### **2. Vista de desempeño de repartidores**
Incluye:
- Número total de entregas  
- Zona asignada  
- Tiempo promedio de entrega  

### **3. Vista de ingredientes bajo el stock mínimo**
Permite identificar rápidamente los ingredientes que requieren reposición.

---

## Requisitos Previos

- MySQL **8.0 o superior**  
- Cliente SQL: Workbench, DBeaver, consola MySQL u otro compatible  
- Conexión configurada correctamente para ejecutar los scripts

---

## Instrucciones Básicas de Uso

1. Crear o limpiar la base de datos ejecutando el archivo **database.sql**.  
2. Ejecutar los scripts en el orden recomendado:
```
database.sql

funciones.sql

triggers.sql

vistas.sql

consultas.sql
```

3. Utilizar las funciones, procedimientos y vistas para generar reportes operativos y cálculos del sistema.

---

## Notas Importantes

- Es recomendable ejecutar los scripts en el orden indicado para evitar errores de dependencia.  
- Las funciones y triggers están diseñados específicamente para la estructura del caso de estudio. Modificar las tablas sin ajustar estos elementos puede provocar fallos.  
- El porcentaje de IVA y otros valores parametrizables pueden ajustarse según las necesidades del negocio.

