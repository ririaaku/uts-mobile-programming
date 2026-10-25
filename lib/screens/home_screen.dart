
import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/game_model.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color darkGreen = Color(0xFF1A3336);
  static const Color orange = Color(0xFFFFA726);
  static const Color backgroundColor = Color(0xFFFFF8E8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: FutureBuilder<List<Game>>(
        future: loadGamesJson(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: darkGreen),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Gagal memuat data JSON'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Data game tidak tersedia'),
            );
          }

          final games = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER DAN PENCARIAN
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 45, 20, 24),
                  decoration: const BoxDecoration(
                    color: darkGreen,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.sports_esports,
                            color: Colors.white,
                            size: 25,
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              'GameZone',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications,
                              color: orange,
                            ),
                          ),
                          const CircleAvatar(
                            radius: 15,
                            backgroundColor: Color(0xFF34504D),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Cari game...',
                          hintStyle: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color(0xFFE8D9A8),
                            size: 20,
                          ),
                          suffixIcon: const Icon(
                            Icons.mic,
                            color: orange,
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.12),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                // KATEGORI GAME
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCat(Icons.gps_fixed, const Color(0xFFFF981F)),
                      _buildCat(Icons.directions_car, const Color(0xFFD98268)),
                      _buildCat(Icons.sports_esports, const Color(0xFFE9C77A)),
                      _buildCat(Icons.sports_basketball, const Color(0xFFE9C77A)),
                    ],
                  ),
                ),

                const SizedBox(height: 26),

                // JUDUL GAME POPULER
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Game Populer',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: darkGreen,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_left,
                        color: Colors.grey.shade400,
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: darkGreen,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // KARTU GAMBAR GAME POPULER
                SizedBox(
                  height: 112,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: games.length,
                    itemBuilder: (context, index) {
                      final game = games[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailScreen(game: game),
                            ),
                          );
                        },
                        child: Container(
                          width: 165,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(13),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.10),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(13),
                            child: Image.network(
                              game.imageUrl,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;

                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: orange,
                                    strokeWidth: 2,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: const Color(0xFFE8E4D9),
                                  child: const Icon(
                                    Icons.broken_image,
                                    color: darkGreen,
                                    size: 35,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 25),

                // JUDUL GAME TERBARU
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Game Terbaru',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // DAFTAR GAME TERBARU
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: games.length,
                  itemBuilder: (context, index) {
                    final game = games[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // GAMBAR THUMBNAIL
                          ClipRRect(
                            borderRadius: BorderRadius.circular(9),
                            child: SizedBox(
                              width: 65,
                              height: 65,
                              child: Image.network(
                                game.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: const Color(0xFFE8E4D9),
                                    child: const Icon(
                                      Icons.gamepad,
                                      color: darkGreen,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          const SizedBox(width: 10),

                          // INFORMASI GAME
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  game.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: darkGreen,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  game.category,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  game.releaseDate,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFFB68B40),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 6),

                          // TOMBOL INFO
                          SizedBox(
                            height: 34,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DetailScreen(game: game),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: orange,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                'Info',
                                style: TextStyle(fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCat(IconData icon, Color color) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: color,
      child: Icon(
        icon,
        color: Colors.white,
        size: 23,
      ),
    );
  }
}
