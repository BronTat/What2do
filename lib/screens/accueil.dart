
import 'package:flutter/material.dart';
import 'package:todolist_app/widget.dart';

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
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 32.0,
          ),
          color: Color(0xFF171717),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom:32
                ),
                child: Image(image: AssetImage(
                  'assets/images/logo.png'
                )),
              ),
              TacheWidget()
            ],
          )
        ),
      ),
    );
  }
}
