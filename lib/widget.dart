import 'package:flutter/material.dart';

class TacheWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      //Ajout d'un padding sur ce widget
      width: double.infinity,
      padding:EdgeInsets.symmetric(
        vertical: 32,
        horizontal: 24
      ),

      //Ajout d'un borderradius
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        //Ajoute une couleur de background
        color: Color(0xFFFFFFFF),
      ),
      child: Text(
        "Débuter avec What2Do",
        //Surcharge pour redéfinir le style du texte
        style: TextStyle(
          fontSize: 22,
            fontWeight : FontWeight.bold,
          color: Color(0xFF171717),
        ),

      ),
    );
  }
}
