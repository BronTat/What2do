
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
            horizontal: 24.0
          ),
          color: Color(0xFF171717),
          //Stack - superposition
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    //placement du bouton (+)
                    margin: EdgeInsets.only(
                      top: 32,
                      //avant à 32 mais renderFlex overflowed
                      bottom: 32,
                    ),
                    child: Image(image: AssetImage(
                      'assets/images/logo.png'
                    )),
                  ),
                Expanded( //signifie qu'on peut naviger dans nos listes
                  child: ListView( // ListView pour avoir plusieurs list de toDoList
                    children: [
                      TacheWidget(
                        //titre passé en paramètre
                          title: "Débuter avec What2Do :)",
                          desc : "Bonjour, utilisateur ! Bienvenue sur cette application. Sur cet écran, vous pourrez visualiser l'ensemble de vos listes, en ajouter ou en supprimer"
                      ),
                      TacheWidget(),
                      TacheWidget(),
                      TacheWidget(),
                    ],
                  ),
                )
                ],
              ),
              //Au lieu d'un floatingbutton
              Positioned(
                bottom: 24,
                right: 0,
                child: Container(
                  width: 60,
                    height:60,
                  decoration: BoxDecoration(
                    color: Color(0xFF148BCC),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child:Image(
                    //bouton flottant
                    image: AssetImage(
                      'assets/images/add_icon.png'
                    ),
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
