class Tache {
  final int id;
  final String titre;
  final String description;
  final int couleurFond;

  Tache({this.id, this.titre, this.description, this.couleurFond});

  //méthode qui va nous aider à convertir les dataObject en Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titre': titre,
      'description': description,
      'couleurFond': couleurFond,
    };
  }
}
