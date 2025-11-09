
import 'package:flutter/material.dart';

class CoursesScreen extends StatelessWidget {
  final courses = [
    'Psychology',
    'Accounting',
    'Artificial Intelligence',
    'Human Development',
    'Information Technology',
    'Business Administration',
    'Training of Trainers (T.O.T)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Courses')),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: courses.length,
        itemBuilder: (_, i) => Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: EdgeInsets.symmetric(vertical:8),
          child: ListTile(
            title: Text(courses[i]),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
