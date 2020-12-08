import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist_app/bdd_gestion.dart';
import 'package:todolist_app/modeles/todo.dart';
import 'package:todolist_app/widget.dart';
import 'file:///C:/Users/nicolas.jeanmair/AndroidStudioProjects/ToDoListFlutter/lib/modeles/tache.dart';

class pageDesTaches extends StatefulWidget {
  final Tache tache;

  pageDesTaches({@required this.tache});

  @override
  _TacheState createState() => _TacheState();
}

class _TacheState extends State<pageDesTaches> {
  BDDGestion bddgestion = BDDGestion();
  int tacheId = 0;
  String titreTache = "";
  String descTache ="";

  FocusNode focusTitre;
  FocusNode focusDescription;
  FocusNode focusTodo;

  //gestion de ce qui doit être visible ou pas
  bool contenuVisible = false;

  @override
  void initState() {
    if (widget.tache != null) {
      contenuVisible = true;
      titreTache = widget.tache.titre;
      descTache = widget.tache.description;
      tacheId = widget.tache.id;
    }

    focusTitre = FocusNode();
    focusDescription = FocusNode();
    focusTodo = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    focusTitre.dispose();
    focusDescription.dispose();
    focusTodo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 24.0,
                      bottom: 6.0,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          //zone rectangulaire qui répond au toucher
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Image(
                              image: AssetImage('assets/images/retour.png'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: focusTitre,
                            onSubmitted: (value) async {
                              //test si le champ n'est pas vide
                              if (value != "") {
                                //  test si la tache est vide
                                if (widget.tache == null) {
                                  Tache newTache = Tache(titre: value);

                                  tacheId =
                                      await bddgestion.insertTache(newTache);
                                  setState(() {
                                    contenuVisible = true;
                                    titreTache = value;
                                  });
                                } else {
                                  await bddgestion.updateTitreTache(
                                      tacheId, value);
                                  print("update :");
                                }
                                focusDescription.requestFocus();
                              }
                            },
                            controller: TextEditingController()
                              ..text = titreTache,
                            decoration: InputDecoration(
                                hintText: "Entrez le nom de la ToDoList",
                                border: InputBorder.none),
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF86829D)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: contenuVisible,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 12.0,
                      ),
                      child: TextField(
                        focusNode: focusDescription,
                        onSubmitted: (value) {
                          if (value != "") {
                            if (tacheId != 0) {
                              bddgestion.updateDescriptionTache(tacheId, value);
                            }
                          }
                          focusTodo.requestFocus();
                        },
                        controller: TextEditingController()..text=descTache,
                        decoration: InputDecoration(
                            hintText: "description de la ToDoList",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 24.0,
                            )),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: contenuVisible,
                    child: FutureBuilder(
                      initialData: [],
                      future: bddgestion.getTodos(tacheId),
                      builder: (context, snapshot) {
                        return Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: ToDoWidget(
                                    texte: snapshot.data[index].titre,
                                    estFait: snapshot.data[index].estFait == 0
                                        ? false
                                        : true,
                                  ),
                                );
                              }),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: contenuVisible,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20.0,
                            height: 20.0,
                            margin: EdgeInsets.only(
                              right: 16.0,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: Color(0xFF86829D), width: 1.5)),
                            child: Image(
                              image: AssetImage('assets/images/fleche.png'),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              focusNode: focusTodo,
                              onSubmitted: (value) async {
//test si le champ n'est pas vide
                                if (value != "") {
                                  //  test si la tache est vide
                                  if (widget.tache != null) {
                                    BDDGestion bddgestion = BDDGestion();
                                    Todo newTodo = Todo(
                                      titre: value,
                                      estFait: 0,
                                      tacheId: widget.tache.id,
                                    );

                                    await bddgestion.insertTodo(newTodo);
                                    setState(() {});
                                  } else {
                                    print("fuck new otdo");
                                  }
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Entrez la tache",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Visibility(
                visible: contenuVisible,
                child: Positioned(
                  bottom: 24,
                  right: 24,
                  child: GestureDetector(
                    //ajout d'une action sur le bouton (+)
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => pageDesTaches()),
                      );
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xFF148BCC),
                          borderRadius: BorderRadius.circular(20)),
                      child: Image(
                        //bouton flottant
                        image: AssetImage('assets/images/supprimer.png'),
                      ),
                    ),
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
