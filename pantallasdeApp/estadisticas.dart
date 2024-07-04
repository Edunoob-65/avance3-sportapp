import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Estadisticas extends StatefulWidget {
  @override
  _TeamListPageState createState() => _TeamListPageState();
}

class _TeamListPageState extends State<Estadisticas> {
  List<Map<String, dynamic>> teams = [
    {'id': 30, 'name': 'Peru', 'logo': 'https://media.api-sports.io/football/teams/30.png'},
    {'id': 33, 'name': 'Brazil', 'logo': 'https://media.api-sports.io/football/teams/33.png'},
    {'id': 41, 'name': 'Argentina', 'logo': 'https://media.api-sports.io/football/teams/41.png'},
    {'id': 42, 'name': 'Chile', 'logo': 'https://media.api-sports.io/football/teams/42.png'},
    {'id': 46, 'name': 'France', 'logo': 'https://media.api-sports.io/football/teams/46.png'},
    {'id': 50, 'name': 'Germany', 'logo': 'https://media.api-sports.io/football/teams/50.png'},
    {'id': 52, 'name': 'Italy', 'logo': 'https://media.api-sports.io/football/teams/52.png'},
    {'id': 54, 'name': 'Spain', 'logo': 'https://media.api-sports.io/football/teams/54.png'},
    {'id': 57, 'name': 'England', 'logo': 'https://media.api-sports.io/football/teams/57.png'},
    {'id': 61, 'name': 'Netherlands', 'logo': 'https://media.api-sports.io/football/teams/61.png'},

  ];

  Map<String, dynamic>? selectedTeamStats;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona un Equipo'),
      ),
      body: ListView.builder(
        itemCount: teams.length,
        itemBuilder: (context, index) {
          final team = teams[index];
          return ListTile(
            leading: Image.network(
              team['logo'],
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(team['name']),
            onTap: () {
              fetchTeamStats(team['id']);
            },
          );
        },
      ),
    );
  }

  Future<void> fetchTeamStats(int teamId) async {
    final String apiUrl = 'https://api-football-v1.p.rapidapi.com/v3/teams/statistics?league=39&season=2023&team=$teamId';
    final headers = {
      'x-rapidapi-key': 'cbfe4addd6msh77bab7ee9f82bddp1bde33jsn5057d42a9029',
      'x-rapidapi-host': 'api-football-v1.p.rapidapi.com',
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        setState(() {
          selectedTeamStats = json.decode(response.body)['response'];
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DescripcionEstadisticas(selectedTeamStats!),
          ),
        );
      } else {
        throw Exception('fallo al cargar datos');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

class DescripcionEstadisticas extends StatelessWidget {
  final Map<String, dynamic> teamStats;

  DescripcionEstadisticas(this.teamStats);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estadísticas del Equipo'),
      ),
      body: Center(
        child: TeamStatsWidget(teamStats),
      ),
    );
  }
}

class TeamStatsWidget extends StatelessWidget {
  final Map<String, dynamic> teamStats;

  TeamStatsWidget(this.teamStats);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          teamStats['team']['logo'],
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 16),
        Text(
          teamStats['team']['name'],
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text(
          'Estadísticas de la Temporada ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        _itemEstructura('Partidos Jugados', teamStats['fixtures']['played']['total'].toString()),
        _itemEstructura('Victorias', teamStats['fixtures']['wins']['total'].toString()),
        _itemEstructura('Empates', teamStats['fixtures']['draws']['total'].toString()),
        _itemEstructura('Derrotas', teamStats['fixtures']['loses']['total'].toString()),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _itemEstructura(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}