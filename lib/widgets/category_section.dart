import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kategori',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CategoryCard(icon: Icons.person, label: 'Personal', color: Colors.purple[100]!),
            CategoryCard(icon: Icons.work, label: 'Pekerjaan', color: Colors.green[100]!),
            CategoryCard(icon: Icons.school, label: 'Akademik', color: Colors.blue[100]!),
            CategoryCard(icon: Icons.directions_car, label: 'Perjalanan', color: Colors.orange[100]!),
            CategoryCard(icon: Icons.favorite, label: 'Kesehatan', color: Colors.red[100]!),
            AddCategoryCard(),
          ],
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  CategoryCard({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: color,
          child: Icon(icon, color: Colors.black),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}

class AddCategoryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.grey[300],
          child: Icon(Icons.add, color: Colors.black),
        ),
        SizedBox(height: 8),
        Text('', style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
