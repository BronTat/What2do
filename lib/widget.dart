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
            title ?? "Liste vide",
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
  final String texte;
  final bool estFait;

  ToDoWidget({this.texte, @required this.estFait});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      child: Row(
        children: [
          Positioned(
            child: Column(
              children: [
                Container(
                  width: 20.0,
                  height: 20.0,
                  margin: EdgeInsets.only(
                    right: 16.0,
                  ),
                  decoration: BoxDecoration(
                      color: estFait ? Color(0xFF148BCC) : Colors.transparent,
                      borderRadius: BorderRadius.circular(6.0),
                      border: estFait
                          ? null
                          : Border.all(color: Color(0xFF86829D), width: 1.5)),
                  child: Image(
                    image: AssetImage('assets/images/fleche.png'),
                  ),
                ),
              ],
            ),
          ),
          Text(
            texte ?? "ToDo vide",
            style: TextStyle(
              color: estFait ? Color(0xFF148BCC) : Color(0xFF86829D),
              fontSize: 16.0,
              fontWeight: estFait ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

//Enlever le glow
class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
