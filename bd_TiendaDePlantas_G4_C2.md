


Universidad Nacional del Nordeste
Facultad de Ciencias Exactas y Naturales y Agrimensura



Asignatura: Bases de Datos I (FaCENA-UNNE)
Profesor: Darío Oscar Villegas



Proyecto de Estudio: 
Diseño e Implementación de una Base de Datos para la Gestión Interna de una Tienda de Plantas.


Autores:
Fernandez, Juan Tomás.                            LU: 56305
Román, Gabriel Esteban.                           LU: 52658
Torreani Cáceres, Jimena Soraya.                  LU: 48353
Verdichio, Nicolás Mauricio.                      LU: 56570 




Año: 2024
ÍNDICE O SUMARIO:

PORTADA/PRESENTACIÓN	1
ÍNDICE O SUMARIO:	2
CAPÍTULO I: INTRODUCCIÓN	3
   Tema	3
    Definición o Planteamiento del Problema	3
    Objetivo del Trabajo Práctico:	3
    Objetivos Generales	3
    Objetivos Específicos	3
CAPÍTULO II: MARCO CONCEPTUAL O REFERENCIAL	4
CAPÍTULO III: METODOLOGÍA SEGUIDA	4
CAPÍTULO IV: DESARROLLO DEL TEMA / PRESENTACIÓN DE RESULTADOS	5
CAPÍTULO V: CONCLUSIONES	6
BIBLIOGRAFÍA DE CONSULTA	6



CAPÍTULO I: INTRODUCCIÓN

a.Tema:
Este trabajo práctico se enfoca en el diseño e implementación de una base de datos para la gestión de una tienda de plantas que ofrece productos como plantas, macetas y herramientas o accesorios de jardinería. El propósito es resolver problemas relacionados con la administración de la tienda, como el control del inventario, la gestión de ventas y el seguimiento de clientes. El sistema que se desarrollará está orientado a optimizar estos procesos, centralizando toda la información clave en una base de datos relacional.

b. Definición o Planteamiento del Problema:
Uno de los principales desafíos de un dueño y administrador de una tienda de plantas es mantener un control preciso sobre los productos, el inventario y las ventas. La falta de un sistema de gestión adecuado para el manejo de ventas y stock ha llevado a la necesidad de mejorar la administración de los datos y optimizar la gestión del negocio.

El problema central se define como la necesidad de implementar un sistema automatizado que facilite la gestión del inventario, manteniéndolo actualizado, y permita administrar de manera eficiente el catálogo de productos y el seguimiento de clientes para, en efecto, ofrecer un manejo consistente de los datos. Lo que nos lleva a una serie de interrogantes a los que buscaremos dar respuesta en la base de datos: ¿Qué mecanismos pueden implementarse para alertar al administrador cuando el stock de un producto en específico es insuficiente o está agotado?, ¿cómo se puede garantizar la consistencia e integridad de los datos en el sistema, evitando duplicación y/o pérdida de información? y ¿qué consultas y reportes pueden generarse para facilitar la gestión diaria del inventario, las ventas y los clientes? Estas preguntas nos permitirán una mejor toma de decisiones y, en consecuencia, favorecerán las operaciones de la empresa. 
 

c. Objetivo del Trabajo Práctico:
i. Objetivo General:
Desarrollar una base de datos que resuelva las dificultades de administración de la tienda de plantas, integrando de manera eficiente la gestión de productos, ventas y clientes, garantizando la consistencia y disponibilidad de la información.
ii. Objetivos Específicos:
Diseñar un modelo de datos que refleje de manera clara y precisa las operaciones diarias de la tienda.
Implementar mecanismos de control en la base de datos para asegurar la integridad y consistencia de la información.
Desarrollar un sistema que permita realizar consultas y reportes de manera rápida, facilitando la toma de decisiones basada en datos.
Optimizar la gestión de ventas, inventario y clientes mediante la implementación de funcionalidades de registro y actualización de información.

Alcance del Proyecto:
Este proyecto, se centra en el diseño e implementación de una base de datos relacional para la gestión interna de una tienda de plantas. Para definir el alcance de nuestro trabajo hemos establecido diferentes ejes, los cuales explicitaremos a continuación:
Gestión de Productos: Planteamos hacer un registro de plantas, macetas y herramientas o accesorios de jardinería almacenando información relevante como descripción, precio, stock y especificaciones entre otros datos. Categoría de productos y control de inventario.
Gestión de Clientes: Registro y almacenamiento de la información de los clientes. Historial de compras de los clientes.
Gestión de Pedidos: Registro de pedidos realizados por los clientes. Almacenamiento de los productos incluidos en cada pedido y la cantidad solicitada.
Análisis de Ventas: Consultas sobre productos más vendidos. Registro de la cantidad de productos vendidos y los ingresos generados.
Límites del Proyecto: 
El proyecto no incluirá las siguientes áreas, ya que no forman parte del enfoque actual del sistema de ventas:
Sistema de Pagos y Facturación: No se desarrollará ningún módulo para procesar pagos o emitir facturas. Las transacciones monetarias no serán gestionadas por este sistema. El manejo de impuestos, facturación y métodos de pago (tarjeta de crédito, débito, etc.) queda fuera del alcance.
Logística de Envíos: No se incluirá la gestión de envíos o el seguimiento de los productos hasta la entrega a los clientes. El foco estará en el registro de pedidos sin incluir el procesamiento de la entrega.
Promociones y Descuentos: No se incluirán funcionalidades relacionadas con la gestión de promociones, cupones de descuento o programas de fidelización de clientes.
Estos aspectos podrían tratarse en fases posteriores, en caso de que el negocio crezca y requiera un sistema más avanzado, como la implementación de una tienda online o la integración con proveedores.

CAPÍTULO II: MARCO CONCEPTUAL O REFERENCIAL
El desarrollo de este proyecto está destinado a generar conocimientos y habilidades en cuanto a la implementación de temas técnicos de bases de datos, muy importantes en esta área de investigación y de gran utilidad.. 
Los temas técnicos planteados están relacionados a la seguridad de los datos en una base de datos, la configuración y restricción de perfiles de distintos usuarios que acceden a las bases de datos, la optimización, eficiencia y rendimiento con la que puede llegar a trabajar el motor de bases de datos en momentos de ejecución de consultas, la creación de procedimientos almacenados definidos por el usuarios o por el sistema y las funciones almacenadas, y..(lo que refiere al tema vistas y vistas indexadas) , etc..
A continuación daremos una explicación teórica concisa y lo más concreta posible para cada uno de estos temas técnicos.:

Tema: Manejo de permisos a nivel de usuarios de base de datos.

Tema: Procedimientos y funciones almacenadas.
Los procedimientos y funciones almacenadas son bloques de código SQL pre compilados y almacenados directamente en una base de datos. Esto significa que en lugar de enviar múltiples instrucciones SQL individuales a la base de datos cada vez que se necesita realizar una operación, se puede llamar a un único procedimiento o función que contiene todas las instrucciones necesarias.
Un procedimiento almacenado de SQL Server es un grupo de una o varias instrucciones Transact-SQL . Los procedimientos pueden:
Aceptar parámetros de entrada y devolver varios valores en forma de parámetros de salida al programa que realiza la llamada.
Transacciones: Los procedimientos almacenados pueden agrupar múltiples operaciones en una transacción, asegurando la integridad de los datos.
Devolver un valor de estado a un programa que realiza una llamada para indicar si la operación se ha realizado correctamente o se han producido errores, y el motivo de estos.
Funciones Almacenadas
Una función almacenada es similar a un procedimiento, pero con algunas diferencias clave:
Retorno de un valor: Una función siempre devuelve un único valor. Este valor puede ser de cualquier tipo de datos soportado por SQL Server.
Uso en expresiones: Las funciones pueden utilizarse directamente en expresiones SQL, mientras que los procedimientos requieren una instrucción EXECUTE.
Sin instrucciones de flujo de control: Las funciones están más restringidas en cuanto a las instrucciones que pueden contener. Por ejemplo, no pueden ejecutar instrucciones como INSERT, UPDATE o DELETE directamente.
Ventajas de usar Procedimientos y Funciones almacenadas
Tráfico de red reducido: Los comandos de un procedimiento se ejecutan en un único lote de código. Esto puede reducir significativamente el tráfico de red entre el servidor y el cliente porque únicamente se envía a través de la red la llamada que va a ejecutar el procedimiento. Sin la encapsulación de código que proporciona un procedimiento, cada una de las líneas de código tendría que enviarse a través de la red.
Mayor seguridad: Varios usuarios y programas cliente pueden realizar operaciones en los objetos de base de datos subyacentes a través de un procedimiento, aunque los usuarios y los programas no tengan permisos directos sobre esos objetos subyacentes. El procedimiento controla qué procesos y actividades se llevan a cabo y protege los objetos de base de datos subyacentes. Esto elimina la necesidad de conceder permisos en cada nivel de objetos y simplifica los niveles de seguridad.
La cláusula EXECUTE AS puede especificarse en la instrucción CREATE PROCEDURE para habilitar la suplantación de otro usuario o para permitir que los usuarios o las aplicaciones puedan realizar ciertas actividades en la base de datos sin necesidad de contar con permisos directos sobre los objetos y comandos subyacentes. 
Cuando una aplicación llama a un procedimiento a través de la red, solo está visible la llamada que va a ejecutar el procedimiento. Por tanto, los usuarios malintencionados no pueden ver los nombres de los objetos de la base de datos y las tablas, insertar sus propias instrucciones Transact-SQL ni buscar datos críticos.
El uso de parámetros de procedimientos ayuda a protegerse contra ataques por inyección de código SQL. Dado que la entrada de parámetros se trata como un valor literal y no como código ejecutable, resulta más difícil para un atacante insertar un comando en las instrucciones Transact-SQL del procedimiento y poner en peligro la seguridad.
Reutilización de Código: El código de cualquier operación de base de datos redundante resulta un candidato perfecto para la encapsulación de procedimientos. De este modo, se elimina la necesidad de escribir de nuevo el mismo código, se reducen las inconsistencias de código y se permite que cualquier usuario o aplicación que cuente con los permisos necesarios pueda acceder al código y ejecutarlo.
Mantenimiento más sencillo: Al centralizar la lógica de la base de datos, facilitan el mantenimiento y las actualizaciones.
Rendimiento mejorado: De forma predeterminada, un procedimiento se compila la primera vez que se ejecuta y crea un plan de ejecución que vuelve a usarse en posteriores ejecuciones.
Al estar precompilados, se ejecutan más rápido que las instrucciones SQL individuales.

Tipos de Procedimientos almacenados
Procedimientos Almacenados Definidos por el Usuario: Un procedimiento definido por el usuario se puede crear en una base de datos definida por el usuario o en todas las bases de datos del sistema excepto en la base de datos Resource. El procedimiento se puede desarrollar en Transact-SQL o como referencia a un método de Common Language Runtime (CLR) de Microsoft .NET Framework.
Procedimientos Almacenados del Sistema: Los procedimientos del sistema se incluyen con el motor de base de datos. Están almacenados físicamente en la base de datos interna y oculta Resource y se muestran de forma lógica en el esquema sys de cada base de datos definida por el sistema y por el usuario. Además, la base de datos msdb también contiene procedimientos almacenados del sistema en el esquema dbo que se usan para programar alertas y trabajos. Dado que los procedimientos del sistema empiezan con el prefijo sp_, le recomendamos que no use este prefijo cuando asigne un nombre a los procedimientos definidos por el usuario.

Tema: optimización de consultas mediante índices  
                                       INDICES
Los Índices son objetos que nos permiten el ordenamiento de los datos de las tablas, son objetos físicos por lo tanto ocupan espacio en el disco menos que una tabla, porque no almacenan todos los datos de la tabla, sino únicamente referencias a ciertos datos claves, que ocupamos para dicha tabla.

Es una copia de todas las filas, pero solamente de algunas columnas de la tabla sobre la cual definimos el índice.

Los Índices se dividen en dos tipos: 
Los Agrupados (Clúster) y los No Agrupados.

INDICES AGRUPADOS: Hace una búsqueda directa. 
Es decir, los nodos hojas contienen las páginas de datos de la tabla.
Un índice agrupado es similar a una guía telefónica, los registros con el mismo valor de campo se agrupan juntos.

INDICES NO AGRUPADOS 
Tiene la misma estructura, pero la última fila de nodos no contiene los datos de la tabla sino contiene punteros que nos deriva a otro espacio físico donde están los datos, los punteros indican el lugar de almacenamiento de los elementos indizados en la tabla.
Es decir, los datos se almacenan en un lugar diferente al del índice.
Llevándolo a el mismo ejemplo de la guía seria buscar primero por el índice y después acceden a la hoja donde está buscando el correspondiente dato.




Tema: vistas y vistas indexadas

CAPÍTULO IV: DESARROLLO DEL TEMA / PRESENTACIÓN DE RESULTADOS 

Este enfoque presenta el análisis detallado del sistema de gestión para la tienda de plantas.
El propósito es que, a través de este sistema, la administración de la tienda sea más eficiente, facilitando tanto la operaciones como la toma de decisiones.
1. Modelo de Datos
El primer paso para implementar este sistema fue diseñar un modelo de datos que refleje las necesidades operativas de la tienda.
El diagrama muestra cómo las distintas áreas del negocio interactúan entre sí. La tabla de productos es esencial, ya que representa el inventario de plantas y productos relacionados. Cada producto tiene un nombre, un tipo (por ejemplo, planta, maceta, herramienta de jardinería), una cantidad disponible en stock y un precio, que son atributos fundamentales para la gestión.
Otra entidad clave es la tabla de clientes, que almacena información detallada de los compradores, permitiendo realizar un seguimiento de las compras y mejorar la experiencia del cliente mediante una atención personalizada.
En la tabla ventas conectan estos elementos, registrando cada transacción realizada. Esto no solo ayuda a llevar un control del flujo de ingresos, sino que también permite analizar el comportamiento de compra y planificar el inventario de manera más precisa.


### Diagrama relacional

![image](https://github.com/user-attachments/assets/2eb35ed2-1a16-4bf9-970a-93524f152c3f)





### Diccionario de datos

Acceso al documento [PDF](Docs/diccionario_datos_tiendaPlantas.pdf) del diccionario de datos.
El diseño de estas tablas garantiza que cada proceso en la tienda sea registrado de manera precisa, evitando duplicidades y asegurando la integridad de los datos.



3. Análisis de Resultados
A partir de este diseño, el sistema permitirá:
Un control eficiente del inventario, con alertas cuando el stock de ciertos productos se esté agotando.
Un registro completo de los clientes, lo que permitirá personalizar las ventas y mejorar la gestión de la relación con los clientes, aumentando las oportunidades de fidelización.
Un seguimiento detallado de las ventas, permitiendo identificar patrones de compra y ajustar la oferta de productos en función de las demandas de los clientes.
Con este sistema, se optimiza tanto la operación interna de la tienda, lo que resulta en una atención  más ágil, mejor disponibilidad de productos y un servicio de mayor calidad. Estos beneficios impactan directamente en la satisfacción del cliente, ofreciéndole una experiencia más eficiente y agradable.








### Desarrollo TEMA 1 "----"

> Acceder a la siguiente carpeta para la descripción completa del tema (script/script_ddl_proyecto.sql)

### Desarrollo TEMA 2 "----"

Proin aliquet mauris id ex venenatis, eget fermentum lectus malesuada. Maecenas a purus arcu. Etiam pellentesque tempor dictum. 

> Acceder a la siguiente carpeta para la descripción completa del tema [scripts-> tema_2](script/tema02_nombre_tema)

... 




