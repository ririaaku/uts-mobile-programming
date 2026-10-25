
import 'package:flutter/material.dart';
import '../models/game_model.dart';

class DetailScreen extends StatelessWidget {
  final Game game;

  const DetailScreen({super.key, required this.game});

  static const Color darkGreen = Color(0xFF1A3336);
  static const Color orange = Color(0xFFFFA726);
  static const Color backgroundColor = Color(0xFFFFF8E8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // BANNER GAME
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.48,
            child: Image.network(
              game.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;

                return const Center(
                  child: CircularProgressIndicator(color: orange),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: darkGreen,
                  child: const Icon(
                    Icons.broken_image,
                    color: Colors.white,
                    size: 45,
                  ),
                );
              },
            ),
          ),

          // TOMBOL KEMBALI
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 16,
            child: CircleAvatar(
              backgroundColor: darkGreen.withOpacity(0.8),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 18,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // PANEL INFORMASI
          Positioned.fill(
            top: MediaQuery.of(context).size.height * 0.39,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // JUDUL GAME
                    Text(
                      game.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: darkGreen,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // LABEL KATEGORI DAN TANGGAL
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildTag(game.category),
                        _buildTag(game.releaseDate),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // SPESIFIKASI MINIMUM
                    const Text(
                      'Spesifikasi Minimum',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: darkGreen,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Wrap(
                      spacing: 7,
                      runSpacing: 7,
                      children: game.systemRequirements.entries.map((entry) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            border: Border.all(
                              color: const Color(0xFFE4D2A5),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${entry.key}: ${entry.value}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: darkGreen,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),

                    // GAMBAR GAME
                    const Text(
                      'Galeri Game',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: darkGreen,
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      height: 125,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildGalleryImage(game.imageUrl, 200),
                          const SizedBox(width: 10),
                          _buildGalleryImage(game.imageUrl, 160),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // DESKRIPSI
                    const Text(
                      'Deskripsi Game',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: darkGreen,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      game.description,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.6,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: const Color(0xFFE4D2A5)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          color: darkGreen,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildGalleryImage(String imageUrl, double width) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: width,
        height: 125,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFFE8E4D9),
              child: const Icon(
                Icons.broken_image,
                color: darkGreen,
              ),
            );
          },
        ),
      ),
    );
  }
}
