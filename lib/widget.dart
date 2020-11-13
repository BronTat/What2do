import 'package:flutter/material.dart';

class TacheWidget extends StatelessWidget{
  final String title;
  final String desc;
  //C'est un constructeur
  TacheWidget({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      //Ajout d'un padding sur ce widget
      width: double.infinity,
      padding:EdgeInsets.symmetric(
        vertical: 32,
        horizontal: 24
      ),
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
                fontWeight : FontWeight.bold,
              color: Color(0xFF171717),
            ),
          ),
          Padding(
            //Ajoute un padding individuel (ici, sur le haut)
            padding: const EdgeInsets.only(top : 8.0),
            child: Text(
                "Bonjour, utilisateur ! Bienvenue sur cette application. Sur cet écran, vous pourrez visualiser l'ensemble de vos listes, en ajouter ou en supprimer",
              style: TextStyle(
              fontSize: 16,
              fontWeight : FontWeight.w600,
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
