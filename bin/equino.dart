import 'package:mysql1/mysql1.dart';
import 'database.dart';







class Caballos {
  int? idCaballo;
  String? nombreCaballo;
  String? numeroChip;
  int ? edadCaballo;
  String? sexoCaballo;
  String? razaCaballo;
  String? capaCaballo;
  String? alimentacion;
  String? enfermedad;
  String? tratamiento;
  String? nombrePotro;
  

  static int? idusuario;


  Caballos();

   Caballos.fromMap(ResultRow map) {
    idCaballo = map['idCaballo'];
    numeroChip = map['numerChip'];
    nombreCaballo =map['nombreCaballo'];
    edadCaballo = map['edadCaballo'];
    sexoCaballo = map['sexoCaballo'];
    razaCaballo = map['razaCaballo'];
    capaCaballo = map['capaCaballo'];
    alimentacion = map['alimentacion'];
    enfermedad = map['enfermedad'];
    tratamiento = map['tratamiento'];
    nombrePotro = map['nombrePotro'];
   


  }
   all() async {
    var conn = await Database().conexion();

    try {
      var resultado = await conn.query('SELECT * FROM Caballos');
     List<Caballos> caballo = resultado.map((row) => Caballos.fromMap(row)).toList();
      return caballo;
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }
insertarCaballo() async {
    var conn = await Database().conexion();
    try {
      await conn.query('INSERT INTO caballos (nombreCaballo,numeroChip,edadCaballo,sexoCaballo,razaCaballo,capaCaballo,alimentacion,enfermedad,tratamiento,nombrePotro) VALUES (?,?,?,?,?,?,?,?,?,?)',
          [nombreCaballo,numeroChip,edadCaballo,sexoCaballo,razaCaballo,capaCaballo,alimentacion,enfermedad,tratamiento,nombrePotro]);
      print('Caballo insertado correctamente');
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }
  
}
