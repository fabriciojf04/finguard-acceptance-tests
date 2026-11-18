# language: es
@EP01
Característica: Captura automática de gastos
  Como joven que paga con Yape/Plin
  Quiero que FinGuard registre mis gastos a partir de las notificaciones
  Para llevar mi control sin digitar cada pago

  Antecedentes:
    Dado que el usuario tiene FinGuard instalado en su teléfono Android

  @AT-01 @US01 @funcional
  Escenario: Captura de un pago desde una notificación (Yape / Plin)
    Dado que el permiso de lectura de notificaciones está activo
    Cuando llega la notificación "Yape: Pagaste S/ 12.50 a Menú Doña Rosa"
    Entonces FinGuard registra un gasto con los siguientes datos
      | comercio       | origen | monto |
      | Menú Doña Rosa | Yape   | 12.50 |
    Y la tarjeta de estado muestra "Captura automática: ACTIVA"
    Y el gasto aparece en la lista de gastos capturados recientemente

  @AT-02 @US01 @funcional
  Escenario: Permiso de lectura revocado
    Dado que el usuario revocó el permiso de lectura de notificaciones
    Cuando llega la notificación "Plin: Pagaste S/ 8.00 a Bodega Don Lucho"
    Entonces FinGuard no registra ningún gasto
    Y se muestra el aviso "Permiso desactivado · Reactivar"

  @AT-03 @US01 @funcional
  Escenario: Notificación que no corresponde a un pago
    Dado que el permiso de lectura de notificaciones está activo
    Cuando llega la notificación "Yape: Invita a un amigo y gana S/ 10"
    Entonces FinGuard no registra ningún gasto
    Y el historial de gastos se mantiene sin cambios

  @AT-04 @US02 @funcional
  Esquema del escenario: Categorización automática de un gasto capturado
    Dado que el permiso de lectura de notificaciones está activo
    Cuando se captura un gasto en "<comercio>" por S/ <monto>
    Entonces el gasto queda asignado a la categoría "<categoría>"

    Ejemplos:
      | comercio           | monto | categoría     |
      | Menú Doña Rosa     | 12.50 | Comida        |
      | Metropolitano      | 3.50  | Transporte    |
      | Cine Plaza         | 15.00 | Diversión     |
      | Comercio Nuevo SAC | 20.00 | Sin categoría |

  @AT-05 @US03 @funcional
  Escenario: Historial ordenado del más reciente al más antiguo
    Dado que FinGuard capturó los siguientes gastos
      | comercio         | fecha      | categoría  | monto |
      | Menú Doña Rosa   | 10/11/2026 | Comida     | 12.50 |
      | Metropolitano    | 12/11/2026 | Transporte | 3.50  |
      | Bodega Don Lucho | 14/11/2026 | Comida     | 8.00  |
    Cuando el usuario abre el historial de gastos
    Entonces ve los gastos en este orden
      | comercio         |
      | Bodega Don Lucho |
      | Metropolitano    |
      | Menú Doña Rosa   |
    Y cada gasto muestra comercio, fecha, categoría y monto

  @AT-06 @US03 @funcional
  Escenario: Historial sin gastos capturados
    Dado que FinGuard aún no capturó ningún gasto
    Cuando el usuario abre el historial de gastos
    Entonces ve el mensaje "Aún no hay gastos capturados"
    Y no se muestra ninguna lista de gastos

  @AT-07 @US04 @funcional
  Escenario: Registro manual de un gasto en efectivo
    Dado que el usuario está en la pantalla de registro manual
    Cuando ingresa los siguientes datos y pulsa "Guardar gasto"
      | monto | descripción  | categoría |
      | 8.00  | Menú del día | Comida    |
    Entonces el gasto aparece en el historial con el monto S/ 8.00
    Y el gasto está marcado como "Manual"

  @AT-08 @US04 @funcional
  Esquema del escenario: Validación del monto en el registro manual
    Dado que el usuario está en la pantalla de registro manual
    Cuando ingresa el monto "<monto>" y pulsa "Guardar gasto"
    Entonces ve el mensaje "El monto debe ser mayor a cero"
    Y el gasto no se guarda

    Ejemplos:
      | monto |
      | 0     |
      | -5    |
      |       |
