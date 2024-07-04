import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListaPartidosEnVivo extends StatefulWidget {
  @override
  _ListaPartidosEnVivoState createState() => _ListaPartidosEnVivoState();
}

class _ListaPartidosEnVivoState extends State<ListaPartidosEnVivo> {
  List<dynamic> partidos = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    obtenerPartidosEnVivo();
  }

  Future<void> obtenerPartidosEnVivo() async {
    final String apiUrl = 'https://api-football-v1.p.rapidapi.com/v3/fixtures?live=all';
    final headers = {
      'x-rapidapi-key': 'cbfe4addd6msh77bab7ee9f82bddp1bde33jsn5057d42a9029',
      'x-rapidapi-host': 'api-football-v1.p.rapidapi.com',
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        setState(() {
          partidos = json.decode(response.body)['response'];
          cargando = false;
        });
      } else {
        throw Exception('Error al cargar los partidos en vivo');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: cargando
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: partidos.length,
              itemBuilder: (context, index) {
                final partido = partidos[index];
                return Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    leading: Container(
                      width: 80,
                      height: 80,
                      child: Image.network(
                        partido['teams']['home']['logo'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Center(
                      child: Text(
                        '${partido['teams']['home']['name']} vs ${partido['teams']['away']['name']}',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Estado: ${partido['fixture']['status']['short']}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Marcador: ${partido['goals']['home'] ?? '0'} - ${partido['goals']['away'] ?? '0'}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Minuto: ${partido['fixture']['status']['elapsed']}',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    trailing: Container(
                      width: 80,
                      height: 80,
                      child: Image.network(
                        partido['teams']['away']['logo'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
