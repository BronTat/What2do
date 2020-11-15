import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            children: [
              InkWell(//zone rectangulaire qui répond au toucher
                onTap: (){
                 Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 24.0
                  ),
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Image(
                            image: AssetImage('assets/images/back_arrow_icon.png'),
                          )),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Entrez le nom de la tâche",
                              border: InputBorder.none
                          ),
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color:Color(0xFFFFFFFF)
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
