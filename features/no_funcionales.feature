# language: es
@EP10
Característica: Requisitos no funcionales de FinGuard
  Como usuario de FinGuard
  Quiero que la app sea rápida, segura, confiable y fácil de configurar
  Para usarla todos los días con confianza

  @AT-15 @US33 @no-funcional @rendimiento
  Escenario: Los gastos aparecen en un máximo de 5 segundos
    Dado que el permiso de lectura de notificaciones está activo
    Y que se envían 50 notificaciones de pago a un Android de gama media
    Cuando FinGuard procesa cada notificación
    Entonces al menos el 95 % de los gastos aparece en el historial
      en un máximo de 5 segundos
    Y la app sigue respondiendo mientras se procesan los pagos

  @AT-16 @US34 @no-funcional @seguridad
  Escenario: Datos financieros cifrados en el dispositivo
    Dado que FinGuard tiene gastos, categorías y metas guardados
    Cuando se inspecciona el almacenamiento local del dispositivo
    Entonces los datos financieros están cifrados
    Y no existe ninguna clave bancaria almacenada

  @AT-17 @US34 @no-funcional @privacidad
  Escenario: Sin respaldo activado, los datos no salen del teléfono
    Dado que el usuario no activó el respaldo en la nube
    Cuando usa la captura, el historial y las alertas durante una sesión de prueba
    Entonces no se envía ningún dato financiero a servidores externos

  @AT-18 @US35 @no-funcional @precisión
  Esquema del escenario: Precisión de la detección de anomalías >= 90 %
    Dado un conjunto de prueba de 100 gastos etiquetados como normales o anómalos
    Y que la precisión es alertas correctas entre alertas emitidas
    Cuando FinGuard emite <emitidas> alertas y <correctas> son correctas
    Entonces la precisión es <precisión>
    Y el resultado de la prueba es "<resultado>"

    Ejemplos:
      | emitidas | correctas | precisión | resultado          |
      | 40       | 37        | 92.5 %    | Aprobado           |
      | 40       | 35        | 87.5 %    | Defecto registrado |

  @AT-19 @US36 @no-funcional @usabilidad
  Escenario: Configuración inicial en menos de 2 minutos
    Dado que 5 usuarios nuevos abren FinGuard por primera vez
    Cuando cada uno completa la guía de permisos y activa la captura
    Entonces el tiempo promedio de configuración es menor a 120 segundos
    Y el proceso no supera 5 pantallas
