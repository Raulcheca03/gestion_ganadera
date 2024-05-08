import 'package:mysql1/mysql1.dart';

import 'Database.dart';

class Usuario {
  // Propiedades
  int? idUsuario;
  String? nombre;
  String? password;
  

  
  // Constructores
  Usuario();

  Usuario.fromMap(ResultRow map) {
    this.idUsuario = map['idusuario'];
    this.nombre = map['nombre'];
    this.password = map['password'];
    
  }

  // Métodos
  loginUsuario() async {
    var conn = await Database().conexion();
    try {
      var resultado = await conn
          .query('SELECT * FROM usuarios WHERE nombre = ?', [this.nombre]);
      Usuario usuario = Usuario.fromMap(resultado.first);
      if (this.password == usuario.password) {
        return usuario;
      } else
        return false;
    } catch (e) {
      print(e);
      return false;
    } finally {
      await conn.close();
    }
  }

  insertarUsuario() async {
    var conn = await Database().conexion();
    try {
      await conn.query('INSERT INTO usuarios (nombre, password) VALUES (?,?)',
          [nombre, password]);
      print('Usuario insertado correctamente');
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }

  all() async {
    var conn = await Database().conexion();

    try {
      var resultado = await conn.query('SELECT * FROM usuarios');
      List<Usuario> usuarios =
          resultado.map((row) => Usuario.fromMap(row)).toList();
      return usuarios;
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }
}
