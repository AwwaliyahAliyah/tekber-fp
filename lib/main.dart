import 'package:flutter/material.dart';
import 'package:progresfp1/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'providers/category_provider.dart';
import 'providers/note_provider.dart';
import 'providers/user_provider.dart';
import 'providers/search_provider.dart';

void main() {
  runApp(NoteTakingApp());
}

class NoteTakingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => NoteProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyNotes+',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          scaffoldBackgroundColor: Colors.blueGrey[100],
        ),
        home: SignUpScreen(),
      ),
    );
  }
}
