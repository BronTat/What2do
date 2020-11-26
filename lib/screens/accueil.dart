import 'package:flutter/material.dart';
import 'package:todolist_app/screens/pageDesTaches.dart';
import 'package:todolist_app/widget.dart';
import 'package:todolist_app/bdd_gestion.dart';

class Accueil extends StatefulWidget {
  @override
  Accueil_State createState() => Accueil_State();
}

class Accueil_State extends State<Accueil> {
  BDDGestion db = BDDGestion();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24.0),
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
                      child: Image(image: AssetImage('assets/images/logo.png')),
                    ),
                    Expanded(
                      //signifie qu'on peut naviger dans nos listes
                      child: FutureBuilder(
                        initialData: [],
                        future: db.getTache(),
                        builder: (context, snapshot) {
                          return ScrollConfiguration(
                            behavior: NoGlowBehaviour(),
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => pageDesTaches(
                                          tache: snapshot.data[index],
                                        )),
                                    );
                                  },
                                  child: TacheWidget(
                                    title: snapshot.data[index].titre,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
                //Au lieu d'un floatingbutton
                Positioned(
                  bottom: 24,
                  right: 0,
                  child: GestureDetector(
                    //ajout d'une action sur le bouton (+)
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => pageDesTaches(tache:null ,)),
                      ).then((value) {
                        setState(() {});
                      });
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              //Dégradé
                              colors: [Color(0xFF148BCC), Color(0xFF86829D)],
                              begin: Alignment(0.0, -1.0),
                              end: Alignment(0.0, 1.0)),
                          //color: Color(0xFF148BCC),
                          borderRadius: BorderRadius.circular(20)),
                      child: Image(
                        //bouton flottant
                        image: AssetImage('assets/images/ajouter.png'),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
