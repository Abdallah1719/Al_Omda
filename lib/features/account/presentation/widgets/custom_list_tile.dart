import 'package:flutter/material.dart';

class CustomAccountTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;
  final Color? iconColor;
  final Widget? trailing;

  const CustomAccountTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.iconColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon, color: iconColor ?? Theme.of(context).primaryColor),
        title: Text(title),
        trailing:
            trailing ??
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      ),
    );
  }
}
