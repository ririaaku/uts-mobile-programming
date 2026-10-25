class Game {
  final String id;
  final String title;
  final String category;
  final String releaseDate;
  final String imageUrl;
  final String description;
  final Map<String, dynamic> systemRequirements;

  Game({
    required this.id,
    required this.title,
    required this.category,
    required this.releaseDate,
    required this.imageUrl,
    required this.description,
    required this.systemRequirements,
  });

  // Fungsi untuk konversi JSON ke Object Flutter
  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      releaseDate: json['releaseDate'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      systemRequirements: Map<String, dynamic>.from(json['systemRequirements']),
    );
  }
}