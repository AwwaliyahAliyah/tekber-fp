import 'package:flutter/material.dart';

// Widget kartu kategori dengan lebar dinamis
class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final double width;

  CategoryCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // Lebar dinamis
      margin: const EdgeInsets.only(right: 16), // Jarak antar kategori
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: color,
            child: Icon(icon, color: Colors.black),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
