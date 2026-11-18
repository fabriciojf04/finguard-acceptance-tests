# language: es
@EP03
Característica: Detección y análisis de gasto hormiga
  Como usuario con ingresos ajustados
  Quiero que FinGuard identifique y clasifique mis gastos hormiga
  Para saber cuánto dinero pierdo sin notarlo y decidir dónde recortar

  Antecedentes:
    Dado que se considera gasto hormiga un gasto de hasta S/ 20.00
    Y que el mismo comercio se repite 3 o más veces en el mes

  @AT-09 @US08 @funcional
  Escenario: Acumulado mensual de gasto hormiga
    Dado que el usuario tiene los siguientes gastos en noviembre de 2026
      | comercio           | veces | monto unitario |
      | Juguería La Fresca | 5     | 6.00           |
      | Kiosko UPC         | 6     | 4.50           |
      | Bodega Don Lucho   | 4     | 3.50           |
    Cuando el usuario abre el resumen de gasto hormiga
    Entonces el acumulado mensual es S/ 71.00
    Y los comercios se ordenan por monto acumulado, de mayor a menor

  @AT-10 @US08 @funcional
  Escenario: Mes sin gasto hormiga
    Dado que ningún comercio tiene 3 o más gastos de hasta S/ 20.00 en el mes
    Cuando el usuario abre el resumen de gasto hormiga
    Entonces el acumulado mensual es S/ 0.00
    Y ve el mensaje "No detectamos gastos hormiga este mes"

  @AT-11 @US09 @funcional
  Esquema del escenario: Clasificación necesario / innecesario
    Dado que FinGuard detectó gasto hormiga en "<comercio>" de tipo "<tipo>"
    Cuando el usuario abre la clasificación de gastos hormiga
    Entonces el gasto aparece como "<clasificación>"

    Ejemplos:
      | comercio        | tipo        | clasificación |
      | Metropolitano   | Pasajes     | Necesario     |
      | Menú Doña Rosa  | Menú diario | Necesario     |
      | Cabina Level Up | Videojuegos | Innecesario   |
      | Cine Plaza      | Salidas     | Innecesario   |

  @AT-12 @US10 @funcional
  Escenario: Ahorro potencial por reducir gastos innecesarios
    Dado que el usuario tiene los siguientes gastos hormiga innecesarios
      | comercio        | monto unitario | veces |
      | Cabina Level Up | 5.00           | 8     |
      | Cine Plaza      | 15.00          | 3     |
    Cuando el usuario abre el ahorro potencial
    Entonces ve el ahorro potencial total de S/ 85.00 al mes
    Y ve el detalle por comercio
      | comercio        | cálculo   | ahorro |
      | Cabina Level Up | 5.00 x 8  | 40.00  |
      | Cine Plaza      | 15.00 x 3 | 45.00  |

  @AT-13 @US10 @funcional
  Escenario: Sin gastos hormiga innecesarios para reducir
    Dado que todos los gastos hormiga del mes son necesarios
    Cuando el usuario abre el ahorro potencial
    Entonces el ahorro potencial total es S/ 0.00
    Y ve un mensaje de felicitación que empieza con "¡Buen trabajo!"
    Y no se muestra ninguna lista de recortes

  @AT-14 @US11 @funcional
  Escenario: Detección de cobros duplicados
    Dado que se considera cobro duplicado el mismo monto en el mismo comercio
    Y que ambos cobros ocurren con menos de 10 minutos de diferencia
    Y que FinGuard capturó el siguiente cobro a las 14:03
      | comercio           | monto |
      | Tienda Online Lima | 59.90 |
    Cuando FinGuard captura a las 14:05 otro cobro del mismo comercio y monto
    Entonces ambos cobros se marcan como "Posible cobro duplicado"
    Y el usuario recibe un aviso para reclamar el reembolso
