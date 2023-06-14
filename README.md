# Prueba Técnica Promass

El actual proyecto es una app móvil, la cual simula un blog, el cual contiene entradas que se componen de un título, autor, fecha de creación y contenido.
La app cuenta con distintas funcionalidades propias de un blog, como crear nuevas entradas, eliminar, actualizar, las entradas ya existentes.

## Comenzando 🚀


### Prerrequisitos 📋

Obligatorio:
-Dispositivo Mac
-Xcode instalado

Opcional: 
-Dispositivo iOS físico con versión de iOS 15 o posterior

### Instalación 🔧

Para la instalación en un dispositivo virtual, solo es necesario clonar el proyecto, abrirlo en Xcode, y en seguida dar en el botón de run, o en su defecto presionar la combinación de teclas (⌘ + R)

## Funcionalidades ⚙️

Como se mencionó en el inicio, la app cuenta con funcionalidades propias de un blog, una de ellas es la consulta de las entradas que ya están creadas, como se puede apreciar en la siguiente imagen:

<img src="https://github.com/AdriaAriasMartinez/PruebaPromass/assets/121067810/5d4721b8-7bb1-4838-a1ef-a479f3a64ce1" alt="Entradas creadas" width="200">


Dentro de esta vista, contamos con un listado de todas las entradas que están en nuestro servidor, además contamos con un elemento UISearchBar, con el cual podemos realizar búsquedas para filtrar nuestras entradas, estas búsquedas, pueden ser por contenido, autor, o título.
Como se puede apreciar en el siguiente ejemplo, las coincidencias de la búsqueda serán filtradas, y mostradas al usuario en el listado de entradas:


<img src="https://github.com/AdriaAriasMartinez/PruebaPromass/assets/121067810/290c7800-576a-416e-87ef-b86d3f519c2d" alt="Hola" width="200">

Dentro de la misma vista, contamos con un botón con el símbolo de (+), el cual al presionarlo, nos dirigirá a la vista de un formulario, en el cual podremos crear una nueva entrada, llenando los datos que se nos piden: 

<img src="https://github.com/AdriaAriasMartinez/PruebaPromass/assets/121067810/294d0af1-b5be-414b-b1a6-913157b9a1b1" alt="Hola" width="200">


La app nos permite asignar una imagen a la entrada que estamos creando, teniendo así, acceso a la galería de nuestro dispositivo.


<img src="https://github.com/AdriaAriasMartinez/PruebaPromass/assets/121067810/c2801668-fe09-456c-be69-f0a6921a9312" alt="Hola" width="200">


Además, se cuenta con una funcionalidad llamada SwipeCell, la cual nos permite deslizar nuestras celdas para realizar diferentes funcionalidades, en este caso, podemos deslizar a la izquierda para eliminar una entrada, o a la derecha para actualizar:


<img src="https://github.com/AdriaAriasMartinez/PruebaPromass/assets/121067810/9b3acc97-d64c-41cd-93cc-7add637294e4" alt="Hola" width="200">             <img src="https://github.com/AdriaAriasMartinez/PruebaPromass/assets/121067810/790ff21f-f32a-4842-b8c9-51b080b225aa" alt="Hola" width="200">


La app cuenta con notificaciones, las cuales nos indican cuando una entrada se subió satisfactoriamente, cuando se completó la actualización, o cuando el título de la entrada ya existe en el servidor, este último con la finalidad de no duplicar entradas, de igual manera cuando el dispositivo no tiene internet.


<img src="https://github.com/AdriaAriasMartinez/PruebaPromass/assets/121067810/2614cffa-689b-4583-b20b-233722e9a281f" alt="Hola" width="200">

Además, cuando no se tiene conexión a internet, el botón de agregar una nueva entrada se oculta en la vista.


<img src="https://github.com/AdriaAriasMartinez/PruebaPromass/assets/121067810/a6232f51-3a2a-4731-abde-d5b0290f1983" alt="Hola" width="200">




## Construido con 🛠️


* [Xcode](https://apps.apple.com/es/app/xcode/id497799835?mt=12) - Entorno de desarrollo usado.
* [Swift](https://www.apple.com/mx/swift/) - Lenguaje de programación.
* [CocoaPods](https://guides.cocoapods.org) - Administrador de dependencias.
* [Firebase](https://firebase.google.com/?hl=es) - Servidor de Base de datos.



--------------------------------------------------------------------------------------------------------------------------------------------------------------------
