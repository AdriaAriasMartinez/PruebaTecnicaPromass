# Prueba Técnica Promass

El actual proyecto es una app móvil, la cual simula un blog, el cual contiene entradas que se componen de un título, autor, fecha de creación y contenido.
La app cuenta con distintas funcionalidades propias de un blog, como crear nuevas entradas, eliminar, actualizar, las entradas ya existentes.

## Comenzando 🚀


### Prerrequisitos 📋

Obligatorio:
-Dispositivo Mac
-Xcode instalado

El proyecto incluye pods, por lo que para su funcionamiento se debera abrir una terminal y ejecutar los siguientes comandos:
cd/ "Ruta del proyecto"
pod install

Opcional: 
-Dispositivo iOS físico con versión de iOS 15 o posterior

### Instalación 🔧

Para la instalación en un dispositivo virtual, solo es necesario clonar el proyecto, abrirlo en Xcode, y en seguida dar en el botón de run, o en su defecto presionar la combinación de teclas (⌘ + R)

## Funcionalidades ⚙️

Como se mencionó en el inicio, la app cuenta con funcionalidades propias de un blog, una de ellas es la consulta de las entradas que ya están creadas, como se puede apreciar en la siguiente imagen:

<img src="https://github.com/AdriaAriasMartinez/PruebaTecnicaPromass/assets/121067810/77c7a800-7cf3-4871-a692-02aa8537b2ea" alt="Entradas creadas" width="200">



Dentro de esta vista, contamos con un listado de todas las entradas que están en nuestro servidor, además contamos con un elemento UISearchBar, con el cual podemos realizar búsquedas para filtrar nuestras entradas, estas búsquedas, pueden ser por contenido, autor, o título.
Como se puede apreciar en el siguiente ejemplo, las coincidencias de la búsqueda serán filtradas, y mostradas al usuario en el listado de entradas:


<img src="https://github.com/AdriaAriasMartinez/PruebaTecnicaPromass/assets/121067810/e743f226-bf68-4ca5-89ec-eb0bcd9a22f8" alt="Hola" width="200">



Dentro de la misma vista, contamos con un botón con el símbolo de (+), el cual al presionarlo, nos dirigirá a la vista de un formulario, en el cual podremos crear una nueva entrada, llenando los datos que se nos piden: 

<img src="https://github.com/AdriaAriasMartinez/PruebaTecnicaPromass/assets/121067810/46b87406-220f-48fd-9630-1796390f1a10" alt="Hola" width="200">



La app nos permite asignar una imagen a la entrada que estamos creando, teniendo así, acceso a la galería de nuestro dispositivo.


<img src="https://github.com/AdriaAriasMartinez/PruebaTecnicaPromass/assets/121067810/8ee92b3f-9cf0-48b6-9785-7116d9d582b9" alt="Hola" width="200">



Además, se cuenta con una funcionalidad llamada SwipeCell, la cual nos permite deslizar nuestras celdas para realizar diferentes funcionalidades, en este caso, podemos deslizar a la izquierda para eliminar una entrada, o a la derecha para actualizar:


<img src="https://github.com/AdriaAriasMartinez/PruebaTecnicaPromass/assets/121067810/e61cba7e-ee0c-40d2-9351-c5aa56c43f14" alt="Hola" width="200">             <img src="https://github.com/AdriaAriasMartinez/PruebaTecnicaPromass/assets/121067810/785c9ec2-d09c-470f-89be-4d026ee7d521" alt="Hola" width="200">




La app cuenta con notificaciones, las cuales nos indican cuando una entrada se subió satisfactoriamente, cuando se completó la actualización, o cuando el título de la entrada ya existe en el servidor, este último con la finalidad de no duplicar entradas, de igual manera cuando el dispositivo no tiene internet.


<img src="https://github.com/AdriaAriasMartinez/PruebaTecnicaPromass/assets/121067810/1c68298a-dc6b-4fa5-a9b2-20fafef920a8" alt="Hola" width="200">

Además, cuando no se tiene conexión a internet, el botón de agregar una nueva entrada se oculta en la vista.

## Construido con 🛠️


* [Xcode](https://apps.apple.com/es/app/xcode/id497799835?mt=12) - Entorno de desarrollo usado.
* [Swift](https://www.apple.com/mx/swift/) - Lenguaje de programación.
* [CocoaPods](https://guides.cocoapods.org) - Administrador de dependencias.
* [Firebase](https://firebase.google.com/?hl=es) - Servidor de Base de datos.



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
