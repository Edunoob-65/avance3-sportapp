import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class DetallePantalla extends StatefulWidget {
  final Map<String, dynamic> team;

  DetallePantalla({required this.team});

  @override
  _DetallePantallaState createState() => _DetallePantallaState();
}

class _DetallePantallaState extends State<DetallePantalla> {
  final translator = GoogleTranslator();
  String descripcionTraduccion = "";

  @override
  void initState() {
    super.initState();
    translateDescription();
  }

  translateDescription() async {
    final translation = await translator.translate(
      widget.team['strDescriptionEN'] ?? 'sin descripcion disponible',
      from: 'en',
      to: 'es',
    );
    setState(() {
      descripcionTraduccion = translation.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color: Color.fromARGB(90, 14, 104, 156),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
              child:Text(
                'Nombre del Equipo: ${widget.team['strTeam']}',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: 
              widget.team['strFanart1'] != null
                  ? Image.network(widget.team['strFanart1'],)
                  : SizedBox(height: 20),
              ),
              SizedBox(height: 16.0),
              Center(child: 
              Text(
                'Estadio: ${widget.team['strStadium']}',
                style: TextStyle(fontSize: 18.0),
              ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: 
              descripcionTraduccion.isEmpty
                  ? CircularProgressIndicator()
                  : Text(
                      'Descripción: $descripcionTraduccion',
                      style: TextStyle(fontSize: 18.0),
                    ),
              ),
                    
            ],
          ),
        ),
      ),
    );
  }
}