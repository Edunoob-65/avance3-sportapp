import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class ListaLigas extends StatefulWidget {
  @override
  _ListaLigasState createState() => _ListaLigasState();
}

class _ListaLigasState extends State<ListaLigas> {
  List<dynamic> ligas = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    obtenerLigas();
  }

  Future<void> obtenerLigas() async {
    final String apiUrl = 'https://api-football-v1.p.rapidapi.com/v3/leagues';
    final headers = {
      'x-rapidapi-key': 'cbfe4addd6msh77bab7ee9f82bddp1bde33jsn5057d42a9029',
      'x-rapidapi-host': 'api-football-v1.p.rapidapi.com',
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        setState(() {
          ligas = json.decode(response.body)['response'];
          cargando = false;
        });
      } else {
        throw Exception('Error al cargar las ligas');
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
              itemCount: ligas.length,
              itemBuilder: (context, index) {
                final liga = ligas[index];
                return ListTile(
                  leading: Image.network(
                    liga['league']['logo'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    liga['league']['name'],
                    style: TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
    );
  }
}
