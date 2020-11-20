class Tache {
  final int id;
  final String titre;
  final String description;
  Tache({this.id,this.titre,this.description});


  //méthode qui va nous aider à convertir les dataObject en Map
  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'title':titre,
      'description':description,
    };
  }
}