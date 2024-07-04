import 'dart:convert';

import 'package:deportesapp/pantallasdeApp/equipos.dart';
import 'package:deportesapp/pantallasdeApp/estadisticas.dart';
import 'package:deportesapp/pantallasdeApp/live.dart';
import 'package:deportesapp/pantallasdeApp/ligas.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        
        appBar: AppBar(
         title: Text('Futbol Mania'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Equipos'),
              Tab(text: 'Estadísticas'),
              Tab(text: 'Ligas'),
              Tab(text: '¡En vivo!'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Equipos(),
            Estadisticas(),
            ListaLigas(),
            ListaPartidosEnVivo(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(String tabName) {

    return Center(
      child: Text(
        'Contenido de la pestaña $tabName',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}






class NovedadesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Novedades', style: TextStyle(fontSize: 24)),
    );
  }
}

class EventosEnVivoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Eventos en Vivo', style: TextStyle(fontSize: 24)),
    );
  }
}

class DeportesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Deportes', style: TextStyle(fontSize: 24)),
    );
  }
}





