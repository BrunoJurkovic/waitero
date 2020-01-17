import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waitero/components/scaffold/custom_scaffold.dart';

void main() => runApp(WaiteroHubApp());

class WaiteroHubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waitero Hub',
      debugShowCheckedModeBanner: false,
      home: CustomScaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Incoming Orders',
                style: GoogleFonts.pTSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 50.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
