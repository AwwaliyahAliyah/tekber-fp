import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lebar dinamis kategori
    final double categoryWidth = MediaQuery.of(context).size.width / 5.5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Kategori',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: List.generate(
                categoryCards.length,
                (index) => categoryCards[index](categoryWidth), // Panggil fungsi widget
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// List kategori
final List<Widget Function(double)> categoryCards = [
  (width) => CategoryCard(
    icon: Icons.person,
    label: 'Personal',
    color: Colors.purple[100]!,
    width: width,
  ),
  (width) => CategoryCard(
    icon: Icons.work,
    label: 'Pekerjaan',
    color: Colors.green[100]!,
    width: width,
  ),
  (width) => CategoryCard(
    icon: Icons.school,
    label: 'Akademik',
    color: Colors.blue[100]!,
    width: width,
  ),
  (width) => CategoryCard(
    icon: Icons.directions_car,
    label: 'Perjalanan',
    color: Colors.orange[100]!,
    width: width,
  ),
  (width) => CategoryCard(
    icon: Icons.favorite,
    label: 'Kesehatan',
    color: Colors.red[100]!,
    width: width,
  ),
  (width) => AddCategoryCard(width: width)
];

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

// Widget untuk tambah kategori
class AddCategoryCard extends StatelessWidget {
  final double width;

  AddCategoryCard({required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // Lebar dinamis
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.add, color: Colors.black),
          ),
          SizedBox(height: 8),
          Text('', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
