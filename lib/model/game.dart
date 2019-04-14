import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Game  {
  const Game({
    @required this.name,
    @required this.box,
    this.cover,
    this.description,
    this.platforms,
    this.rating,
    this.screenshots,
    this.id
  });

  final String name;
  final String box;
  final String cover;
  final String description;
  final  platforms;
  final rating;
  final  screenshots;
  final String id;


  factory Game.fromDocument(DocumentSnapshot document) {
    return new Game(
      name: document['name'],
      box: document['box'],
      cover: document['cover'],
      description: document['description'],
      platforms: document['platforms'],
      screenshots: document['screenshots'],
      rating: document['rating'],
      id: document['id']
    );
  }

  factory Game.fromJSON(Map data) {
    return new Game(
        name: data['name'],
        box: data['box'],
        cover: data['cover'],
        description: data['description'],
        platforms: data['platforms'],
        rating: data['rating'],
        screenshots: data['screenshots'],
        id: data['id']

    );
  }

  String getPlatforms() {
    String platformText = "";
    if (platforms.length > 1) {
      for (int i = 0; i < platforms.length; i++) {
        if (i == 0) {
          platformText = platforms[0];
        } else {
          platformText = platformText + " | " + platforms[i];
        }
      }
    } else if (platforms.length == 1) {
      platformText = platforms[0];
    }

    return platformText;
  }



}
