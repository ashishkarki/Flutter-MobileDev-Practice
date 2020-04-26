import 'package:flutter/material.dart';

class RoughCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SizedBox(
          //   height: 20,
          // ),
          Text(
            'Displaying the proof of being poor',
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              height: 5,
            ),
          ),
          // Expanded(
          //   child:
          Image.asset(
            'assets/images/i-am-poor_body-icon.png',
            fit: BoxFit.cover,
          ),
          //)
        ],
      ),
    );
  }
}
