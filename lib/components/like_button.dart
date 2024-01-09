import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final bool isLiked;
  final VoidCallback onTap;

  LikeButton({required this.isLiked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        isLiked ? Icons.favorite_outline_outlined : Icons.favorite_border,
        color: isLiked ? Colors.red : Colors.black,size: 30,
      ),
    );
  }
}
