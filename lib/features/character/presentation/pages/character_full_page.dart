import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/character/domain/entities/character_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CharacterFullPage extends StatelessWidget {
  final CharacterEntity character;
  final VoidCallback? onToggleFavorite;

  const CharacterFullPage({super.key, required this.character, this.onToggleFavorite});

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return Colors.greenAccent.shade400;
      case 'dead':
        return Colors.redAccent.shade700;
      default:
        return Colors.grey.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           
            Container(
              height: 360,
              color: Colors.grey.shade200,
              child: Stack(
                fit: StackFit.expand,
                children: [
                    CachedNetworkImage(
                      imageUrl: character.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: (context, url) => Container(color: Colors.grey.shade200),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey.shade200,
                        child: const Center(child: Icon(Icons.broken_image, size: 64, color: Colors.grey)),
                      ),
                    ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    top: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: _statusColor(character.status),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.18),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        character.status,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: IconButton(
                      onPressed: onToggleFavorite,
                      icon: Icon(
                        character.isFavorite? Icons.favorite : Icons.favorite_border,
                        color: character.isFavorite? Colors.redAccent : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content (non-scrollable)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Chip(
                          label: Text(character.species),
                        ),
                        const SizedBox(width: 8),
                        Chip(
                          label: Text(character.gender),
                        ),
                        const SizedBox(width: 8),
                        Chip(
                          label: Text(character.type.isEmpty ? 'Type: —' : 'Type: ${character.type}'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Origin', style: TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 6),
                          Text(character.origin.name),
                          const Divider(height: 20),
                          const Text('Location', style: TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 6),
                          Text(character.location.name),
                          const Divider(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
