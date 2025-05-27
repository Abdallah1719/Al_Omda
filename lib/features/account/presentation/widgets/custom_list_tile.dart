import 'package:al_omda/core/utils/index.dart';
import 'package:flutter/material.dart';

class CustomAccountTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;

  const CustomAccountTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon, color: R.colors.primaryColor),
        title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: R.colors.darkgrey,
        ),
      ),
    );
  }
}
