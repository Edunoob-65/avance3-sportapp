import 'package:flutter/material.dart';
import 'package:deportesapp/database/database.dart';
import 'package:deportesapp/models/user.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _register() async {
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (firstName.isNotEmpty && lastName.isNotEmpty && username.isNotEmpty && password.isNotEmpty) {
      User user = User(firstName: firstName, lastName: lastName, username: username, password: password);
      try {
        await DatabaseHelper.insertUser(user);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuario registrado')),
        );
        Navigator.pop(context);
      } catch (e) {
        print('Error al registrar usuario: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al registrar usuario')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, complete todos los campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('imagenes/login.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Regístrate',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 11, 57, 206).withOpacity(0.5),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 300,
                          padding: EdgeInsets.all(7),
                          color: Colors.white.withOpacity(0.5),
                          child: TextField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              labelText: 'Nombre',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 300,
                          padding: EdgeInsets.all(7),
                          color: Colors.white.withOpacity(0.5),
                          child: TextField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              labelText: 'Apellido',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 300,
                          padding: EdgeInsets.all(7),
                          color: Colors.white.withOpacity(0.5),
                          child: TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              labelText: 'Nombre de usuario',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 300,
                          padding: EdgeInsets.all(7),
                          color: Colors.white.withOpacity(0.5),
                          child: TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                            obscureText: true,
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _register,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Text(
                              'Registrar',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    '¿Ya tienes cuenta? Inicia sesión aquí',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
