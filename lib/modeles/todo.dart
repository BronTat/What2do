class Todo{
  final int id;
  final String titre;
  final int estFait;

  Todo({this.id,this.titre,this.estFait});

  //méthode qui va nous aider à convertir les dataObject en Map
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'titre': titre,
      'estFait': estFait,
    };
  }
}