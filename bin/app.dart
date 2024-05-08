import 'dart:io';
import 'equino.dart';
import 'usuario.dart';


class App {
  menuInicial(){
    int? opcion;
    do{
      stdout.writeln('''Elige una opción
      1 - Crear usuario
      2 - Log in''');
      String respuesta = stdin.readLineSync() ?? 'e';
      opcion = int.tryParse(respuesta);
    } while(opcion == null || opcion != 1 && opcion !=2);
    switch(opcion){
      case 1:
        crearUsuario();
        break;
      case 2:
        login();
        break;
      default:
        print('Opción no válida');
    }
  }

  menuLogueado(Usuario usuario) async {
    int? opcion;
    String? nombre = usuario.nombre;
    do{
      stdout.writeln('''Hola, $nombre, elige una opción
      1 - Listar mis caballos
      2 - Insertar caballo
      3 - Salir''');
      String respuesta = stdin.readLineSync() ?? 'e';
      opcion = int.tryParse(respuesta);
    } while(opcion == null || opcion != 1 && opcion !=2 && opcion !=3 );
    switch(opcion){
      case 1:
        await infoCaballo();
        
        menuLogueado(usuario);
        break;
      case 2:
        await insertarCaballo(usuario.idUsuario);
        menuLogueado(usuario);
        break;
      case 3:
        print('Adiós');
        break;
      default:
        print('Opción no válida');
    }
  }

  login() async {
    Usuario usuario = new Usuario();
    stdout.writeln('Introduce tu nombre de usuario');
    usuario.nombre = stdin.readLineSync();
    stdout.writeln('Introduce tu constraseña');
    usuario.password = stdin.readLineSync();
    var resultado = await usuario.loginUsuario();
    if(resultado == false){
      stdout.writeln('Tu nombre de usuario o contraseña son incorrectos');
      menuInicial();
    } else {
      menuLogueado(resultado);
    }
  }

  crearUsuario() async {
    Usuario usuario = new Usuario();
    stdout.writeln('Introduce un nombre de usuario');
    usuario.nombre = stdin.readLineSync();
    stdout.writeln('Introduce una constraseña');
    usuario.password = stdin.readLineSync();
    usuario.password = usuario.password;
    await usuario.insertarUsuario();
    menuInicial();
  }

  listarUsuarios()async{
    List<Usuario> listadoUsuarios = await Usuario().all();
    for(Usuario elemento in listadoUsuarios){
      stdout.writeln(elemento.nombre);
    }
  }

  listarCaballos(int? idcaballo) async{
    var listadoCaballos = await Caballos().all();
    for(Caballos elemento in listadoCaballos){
      stdout.writeln("${elemento.idCaballo} - ${elemento.nombreCaballo}");
    }
    return listadoCaballos;
  }
  
  insertarCaballo(int? idusuario) async {
    Caballos caballo = new Caballos();
    Caballos.idusuario = idusuario;
    stdout.writeln('Introduce el nombre');
    caballo.nombreCaballo = stdin.readLineSync();
    stdout.writeln('numeroChip');
    caballo.numeroChip = stdin.readLineSync();
    stdout.writeln('Introduce la edad del caballo');
    String opcion = stdin.readLineSync() ??"e";
    caballo.edadCaballo = int.tryParse(opcion);
    stdout.writeln('Introduce el sexo');
    caballo.sexoCaballo = stdin.readLineSync();
    stdout.writeln('Introduce la raza');
    caballo.razaCaballo = stdin.readLineSync();
    stdout.writeln('Introduce la capaCaballo');
    caballo.capaCaballo = stdin.readLineSync();
    stdout.writeln('Introduce la alimentacion');
    caballo.alimentacion = stdin.readLineSync();
    stdout.writeln('Introduce la enfermedad');
    caballo.enfermedad = stdin.readLineSync();
    stdout.writeln('Introduce el tratamiento');
    caballo.tratamiento = stdin.readLineSync();
    stdout.writeln('Introduce el nombrePotro');
    caballo.nombrePotro = stdin.readLineSync();
    await caballo.insertarCaballo();

  }



  
  infoCaballo() async {
   List<Caballos> listaCaballos = await Caballos().all();
   for ( Caballos elemento in listaCaballos){
stdout.writeln('El caballo/yegua es ${elemento.nombreCaballo}, es ${elemento.razaCaballo}, tiene ${elemento.edadCaballo} años, es ${elemento.sexoCaballo}, es de capa ${elemento.capaCaballo}, su alimentacion es ${elemento.alimentacion}, esta ${elemento.enfermedad}, tiene que tomar ${elemento.tratamiento}, su potro es ${elemento.nombrePotro} ');
         
   }
       


  }
}