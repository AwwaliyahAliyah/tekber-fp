import 'package:flutter/material.dart';
import '../models/category_model.dart';

// List kategori
final List<Category> initialCategories = [
  Category(
    id: 1,
    icon: Icons.person, 
    label: 'Personal', 
    color: Colors.purple[100]!
  ),
  Category(
    id: 2,
    icon: Icons.work, 
    label: 'Pekerjaan', 
    color: Colors.green[100]!
  ),
  Category(
    id: 3,
    icon: Icons.school, 
    label: 'Akademik', 
    color: Colors.blue[100]!
  ),
  Category(
    id: 4,
    icon: Icons.directions_car, 
    label: 'Perjalanan', 
    color: Colors.orange[100]!
  ),
  Category(
    id: 5,
    icon: Icons.favorite, 
    label: 'Kesehatan', 
    color: Colors.red[100]!
  ),
];
