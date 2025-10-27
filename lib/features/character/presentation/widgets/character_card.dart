import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/character/domain/entities/character_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';

typedef CharacterTapCallback = void Function(CharacterEntity character);
typedef CharacterFavoriteCallback = void Function(CharacterEntity character);

class CharacterCard extends StatelessWidget {
  final CharacterEntity character;
  final CharacterTapCallback? onTap;
  final CharacterFavoriteCallback? onFavoriteTap;

  const CharacterCard({super.key, required this.character, this.onTap, this.onFavoriteTap});

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return Colors.green;
      case 'dead':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
       // onTap: onTap == null ? null : () => onTap!(character),
       onTap: ()=> onTap?.call(character),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image area with favorite button overlay
            SizedBox(
              height: 140,
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
                      alignment: Alignment.center,
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),

                  // Favorite button in top-right corner
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: onFavoriteTap == null ? null : () => onFavoriteTap!(character),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.35),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            character.isFavorite == true ? Icons.favorite : Icons.favorite_border,
                            size: 18,
                            color: character.isFavorite == true ? Colors.redAccent : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${character.species} • ${character.location.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: _statusColor(character.status),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        character.status,
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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
