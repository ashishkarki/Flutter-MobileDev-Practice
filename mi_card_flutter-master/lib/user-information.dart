import 'package:flutter/material.dart';

class UserInformation extends StatelessWidget {
  final IconData icon;
  final String information;
  final double informationFontSize;

  const UserInformation(
    this.icon,
    this.information, {
    this.informationFontSize = 20.0,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      // padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.teal,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              information,
              style: TextStyle(
                color: Colors.teal.shade900,
                fontFamily: 'SourceSansPro',
                fontSize: informationFontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
