import 'package:flutter/material.dart';

class ProfileOption extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final Widget? leading;
  final VoidCallback onTap;

  const ProfileOption(
      this.title, {
        super.key,
        this.trailing,
        this.leading,
        required this.onTap,
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: leading,
        title: Text(title,style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),),
        trailing: trailing ?? Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}

