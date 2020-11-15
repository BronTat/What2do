import 'package:flutter/material.dart';

class TacheWidget extends StatelessWidget {
  final String title;
  final String desc;

  //C'est un constructeur
  TacheWidget({this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      //Ajout d'un padding sur ce widget
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      margin: EdgeInsets.only(bottom: 20),
      //Ajout d'un borderradius
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        //Ajoute une couleur de background
        color: Color(0xFFFFFFFF),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            //Si on a un titre en paramètre on l'affiche sinon ...
            title ?? "Tache vide",
            //Surcharge pour redéfinir le style du texte
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF171717),
            ),
          ),
          Padding(
            //Ajoute un padding individuel (ici, sur le haut)
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              desc ?? "Pas de description",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Color(0xFF171717),
                height: 1.5,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ToDoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
                color: Color(0xFF148BCC),
                borderRadius: BorderRadius.circular(6.0)),
            child: Image(
              image: AssetImage('assests/images/check_icon.png'),
            ),
          ),
          Text("todowidget"),
        ],
      ),
    );
  }
}
