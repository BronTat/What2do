import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist_app/widget.dart';

class Tache extends StatefulWidget {
  @override
  _TacheState createState() => _TacheState();
}

class _TacheState extends State<Tache> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Padding(
          padding: EdgeInsets.only(
            top:24.0,
            bottom: 6.0,
          ),
          child: Row(
            children: [
              InkWell( //zone rectangulaire qui répond au toucher
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Image(
                    image: AssetImage('assets/images/back_arrow_icon.png'),
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Entrez le nom de la tâche",
                      border: InputBorder.none
                  ),
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF)
                  ),
                ),
              )
            ],
          ),
        ),
              Padding(
                padding: EdgeInsets.only(
                  bottom:  12.0,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "description de la tache",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                    )
                  ),
                ),
              ),
              ToDoWidget(
                texte: "Créer ma première tache",
                estFait: false,
              ),
              ToDoWidget(
                texte: "Créer ma deuxieme tache",
                estFait: false,
              ),
              ToDoWidget(
                texte: "Créer ma troisime tache",
                estFait: true,
              ),
              ToDoWidget(
                texte: "Créer ma quatrieme tache",
                estFait: true,
              ),
      ],
    ),)
    ,
    )
    ,
    );
  }
}
