import 'package:flutter/material.dart';
import '../models/category_model.dart';

// List kategori
final List<Category> initialCategories = [
  Category(
    icon: Icons.person, 
    label: 'Personal', 
    color: Colors.purple[100]!
  ),
  Category(
    icon: Icons.work, 
    label: 'Pekerjaan', 
    color: Colors.green[100]!
  ),
  Category(
    icon: Icons.school, 
    label: 'Akademik', 
    color: Colors.blue[100]!
  ),
  Category(
    icon: Icons.directions_car, 
    label: 'Perjalanan', 
    color: Colors.orange[100]!
  ),
  Category(
    icon: Icons.favorite, 
    label: 'Kesehatan', 
    color: Colors.red[100]!
  ),
];
