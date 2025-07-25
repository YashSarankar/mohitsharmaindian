import 'package:flutter/material.dart';

class HomeBanner extends StatelessWidget {
  final String imagePath;
  final String? text;
  final bool isNetwork;
  const HomeBanner({Key? key, required this.imagePath, this.text, this.isNetwork = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageWidget = isNetwork
        ? Image.network(
            imagePath,
            width: 260,
            height: 150,
            fit: BoxFit.cover,
          )
        : Image.asset(
            imagePath,
            width: 260,
            height: 150,
            fit: BoxFit.cover,
          );
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        children: [
          imageWidget,
          if (text != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                color: Colors.black.withOpacity(0.4),
                child: Text(
                  text!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
} 