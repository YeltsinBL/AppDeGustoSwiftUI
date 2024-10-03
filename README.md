# AppDeGustoSwiftUI

Aplicación móvil hecho en SwiftUI  

## Environment Variables

Seguir el siguiente orden para guardar las variables en el mismo XCode.

```sh
 
 # En el menu de XCode
 Product > Scheme > Edit Scheme

 # Se abre una ventana
 Run > Arguments > Environment Variables

#  Hacer clic en el botón " + "
 Escribe el nombre de la variable y su valor

 # Al final hacer clic en el botón "CLOSE"

 # Para usarlo, escribe este código dentro del archivo Swift

 static let nombre_variable = ProcessInfo.processInfo.environment["nombre_variable"] ?? "http://localhost:3000/api/"

```

> Nota: cambia el "nombre_variable" por el nombre que pusiste en Environment Variables.
