import 'package:flutter/material.dart';

class MiCardLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50.0,
          backgroundImage: AssetImage('assets/images/AshishKarki_ProPhoto.jpg'),
        ),
        Text(
          'Ashish Karki',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pacifico',
          ),
        ),
        Text(
          'FLUTTER DEVELOPER',
          style: TextStyle(
            color: Colors.teal.shade100,
            fontSize: 20,
            letterSpacing: 2.5,
            fontWeight: FontWeight.bold,
            fontFamily: 'SourceSansPro',
          ),
        ),
        SizedBox(
          height: 5,
          width: 200,
        ),
        Card(
          elevation: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.phone),
              Text('+977-9841234567'),
            ],
          ),
        ),
        Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.mail),
              Text('ak@gmail.com'),
            ],
          ),
        ),
      ],
    );
  }
}
