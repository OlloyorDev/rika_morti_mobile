import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rika_morti_mobile/core/theme/color/app_colors.dart';
import 'package:rika_morti_mobile/features/home/domain/entities/characters_entity.dart';

class CharacterTile extends StatelessWidget {
  final Character? item;
  final VoidCallback? onTap;
  final bool isFavoriteAdded;

  const CharacterTile({
    super.key,
    required this.item,
    this.onTap,
    this.isFavoriteAdded = false,
  });

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl: item?.image ?? '',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Name: ${item?.name ?? ''}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: onTap,
                      child: Icon(
                        Icons.star,
                        color: isFavoriteAdded
                            ? Colors.amber
                            : AppColors.darkInactiveIcon,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Status: ${item?.status ?? ''}',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                Text(
                  'Species: ${item?.species ?? ''}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                Text(
                  'Location: ${item?.location ?? ''}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
