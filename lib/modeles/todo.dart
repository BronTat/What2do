class Todo{
  final int id;
  final int tacheId;
  final String titre;
  final int estFait;

  Todo({this.id,this.tacheId,this.titre,this.estFait});

  //méthode qui va nous aider à convertir les dataObject en Map
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'tacheId':tacheId,
      'titre': titre,
      'estFait': estFait,
    };
  }
}