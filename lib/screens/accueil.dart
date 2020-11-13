
import 'package:flutter/material.dart';

class Accueil extends StatefulWidget {
  @override
  Accueil_State createState() => Accueil_State();
}

class Accueil_State extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: [
              Image(image: AssetImage(
                'logo.png'
              ))
            ],
          )
        ),
      ),
    );
  }
}
