import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bdd_gestion.dart';

class TacheWidget extends StatelessWidget {
  final String titre;
  final String desc;
  final int couleurFond;

  //C'est un constructeur
  TacheWidget({this.titre, this.desc, this.couleurFond});

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
        color: Color(couleurFond),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            //Si on a un titre en paramètre on l'affiche sinon ...
            titre ?? "Liste vide",
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
  final int index;
  final String dateEcheance;
  final BDDGestion bdd = new BDDGestion();
  String initialValue;
  DateTime startDate;
  DateTime endDate;
  final int couleurFond;

  ToDoWidget({
    this.texte,
    this.dateEcheance,
    @required this.estFait,
    this.index,
    this.couleurFond,
  }) {
    if (dateEcheance == null) {
      initialValue = "";
    } else {
      initialValue = this.dateEcheance;
    }
    DateTime tmp = DateTime.now();
    startDate = DateTime(tmp.year - 5);
    endDate = DateTime(tmp.year + 5);
  }

  // ToDoWidget({this.texte, @required this.estFait});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          Flexible(
            child: Text(
              texte ?? "ToDo vide",
              style: TextStyle(
                color: estFait ? Color(0xFF148BCC) : Color(0xFF86829D),
                fontSize: 16.0,
                fontWeight: estFait ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
          Flexible(
            child: DateTimePicker(
              style: TextStyle(decoration: TextDecoration.none),
              type: DateTimePickerType.dateTime,
              initialValue: initialValue,
              firstDate: startDate,
              lastDate: endDate,
              onChanged: (val) => bdd.updateTodoDateEcheance(index, val),
              onSaved: (val) => print(val),
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
