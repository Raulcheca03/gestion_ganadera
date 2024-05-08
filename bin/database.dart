import 'package:mysql1/mysql1.dart';
class Database {
  // Propiedades
  final String _host = 'localhost';
  final int _port = 3306;
  final String _user = 'root';

  Future<MySqlConnection> conexion() async {
    var settings = ConnectionSettings(
      host: this._host, 
      port: this._port,
      user: this._user,
      db: 'gestionGanaderadb'
    );
      
    return await MySqlConnection.connect(settings);

 
  }

  // Métodos
  instalacion() async {
    var settings = ConnectionSettings(
      host: this._host, 
      port: this._port,
      user: this._user,
      
    );
    var conn = await MySqlConnection.connect(settings);
    try{
      await crearDB(conn);
      await crearTablaCaballos(conn);
      await crearTablaUsuarios(conn);
      await conn.close();
    } catch(e){
      print(e);
      await conn.close();
    } 
  }
  
  crearDB(conn) async {
    await conn.query('CREATE DATABASE IF NOT EXISTS gestionGanaderadb');
    await conn.query('USE gestionGanaderadb');
    print('Conectado a gestionGanaderadb');
  }
  crearTablaUsuarios(conn) async{
    await conn.query('''CREATE TABLE IF NOT EXISTS Usuarios(
    idUsusario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(50) NOT NULL UNIQUE, 
        password VARCHAR (25) NOT NULL
        )''');
        print('tabla usuarios creada');
  } 

  crearTablaCaballos(conn) async {
    await conn.query('''CREATE TABLE IF NOT EXISTS Caballos(
        idCaballo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        nombreCaballo VARCHAR(50) NOT NULL UNIQUE,
        numeroChip VARCHAR(20) NOT NULL,
        edadCaballo INT NOT NULL,
        sexoCaballo VARCHAR (20) NOT NULL,
        razaCaballo VARCHAR (100) NOT NULL,
        capaCaballo VARCHAR (100) NOT NULL,
        alimentacion VARCHAR (100),
        enfermedad VARCHAR(100),
        tratamiento VARCHAR(100),
        nombrePotro VARCHAR(100)
    )''');
    print('Tabla caballos creada');
  }

  
}