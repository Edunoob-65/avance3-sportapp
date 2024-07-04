import 'dart:convert';
import 'package:deportesapp/pantallasdeApp/detalle.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;




class Equipos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Equipos de la Premier League',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePantalla(),
    );
  }
}

class HomePantalla extends StatefulWidget {
  @override
  _HomePantallaState createState() => _HomePantallaState();
}

class _HomePantallaState extends State<HomePantalla> {
  List teams = [];
  bool isLoading = true;
  

  @override
  void initState() {
    super.initState();
    equiposApi();
  }

  equiposApi() async {
    final response = await http.get(Uri.parse('https://www.thesportsdb.com/api/v1/json/3/search_all_teams.php?l=English%20Premier%20League'));

    if (response.statusCode == 200) {
      setState(() {
        teams = json.decode(response.body)['teams'];
        isLoading = false;
      });
    } else {
      throw Exception('Fallo al cargar datos: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: teams[index]['strTeamBadge'] != null
                      ? Image.network(
                          teams[index]['strLogo'],
                          width: 50, 
                        )
                      : null,
                  title: Text(teams[index]['strTeam']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(

                        builder: (context) => DetallePantalla(team: teams[index]),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
