import 'package:flutter/material.dart';

import './user-information.dart';

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
          height: 20,
          width: 150,
          child: Divider(
            color: Colors.teal.shade100,
          ),
        ),
        UserInformation(
          Icons.phone,
          '+977-984000000',
        ),
        UserInformation(
          Icons.mail,
          'ashishk@emailer.com',
          informationFontSize: 15.0,
        ),
      ],
    );
  }
}
