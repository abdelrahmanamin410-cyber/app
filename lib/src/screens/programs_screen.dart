
import 'package:flutter/material.dart';

class ProgramsScreen extends StatelessWidget {
  final programs = [
    {'title':'Professional Diploma Program','duration':'6 months','fee':'\$1200'},
    {'title':'Professional Master\'s Program','duration':'18 months','fee':'\$6000'},
    {'title':'Professional Doctorate Program','duration':'3 years','fee':'\$15000'},
    {'title':'Fellowship Program','duration':'12 months','fee':'\$9000'},
    {'title':'Open Education','duration':'Self-paced','fee':'Free'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Programs')),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: programs.length,
        itemBuilder: (_, i) {
          final p = programs[i];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: EdgeInsets.symmetric(vertical:8),
            child: ListTile(
              title: Text(p['title']!),
              subtitle: Text('${p['duration']} • ${p['fee']}'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){},
            ),
          );
        },
      ),
    );
  }
}
