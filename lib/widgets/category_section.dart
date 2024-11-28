import 'package:flutter/material.dart';
import '../screens/add_category.dart';
import 'package:provider/provider.dart';
import '../providers/category_provider.dart';
import '../widgets/category_card.dart';

class CategorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final categories = categoryProvider.categories;
    
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
              children: [
                // Menampilkan kategori yang ada
                ...categories.map((category) {
                  return CategoryCard(
                    icon: category.icon,
                    label: category.label,
                    color: category.color,
                    width: categoryWidth,
                  );
                }).toList(),
                // Menambahkan tombol AddCategoryCard
                AddCategoryCard(width: categoryWidth),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Widget untuk tambah kategori
class AddCategoryCard extends StatelessWidget {
  final double width;

  AddCategoryCard({required this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddCategoryScreen()),
        ).then((newCategory) {
          if (newCategory != null) {
            Provider.of<CategoryProvider>(context, listen: false).addCategory(newCategory);
          }
        });
      },
      child: Container(
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
      ),
    );
  }
}
