class Todo{
  final int id;
  final int tacheId;
  final String titre;
  final int estFait;
  final String echeance;

  Todo({this.id,this.tacheId,this.titre,this.estFait,this.echeance});

  //méthode qui va nous aider à convertir les dataObject en Map
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'tacheId':tacheId,
      'titre': titre,
      'estFait': estFait,
      'echeance': echeance,
    };
  }
}