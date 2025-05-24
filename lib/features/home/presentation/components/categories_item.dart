// import 'package:al_omda/features/home/data/models/categories_model.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';

// class CategoryItem extends StatelessWidget {
//   final HomeCategoriesModel category;

//   const CategoryItem({super.key, required this.category});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         ClipOval(
//           child: CachedNetworkImage(
//             imageUrl: category.icon,
//             width: 100,
//             height: 100,
//             fit: BoxFit.cover,
//             placeholder: (_, url) => Center(child: CircularProgressIndicator()),
//             errorWidget: (_, url, error) => Icon(Icons.error_outline),
//           ),
//         ),
//         SizedBox(height: 8),
//         Text(
//           category.name,
//           overflow: TextOverflow.ellipsis,
//           style: Theme.of(context).textTheme.bodyLarge,
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }
// }
