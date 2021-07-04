import 'package:flutter/material.dart';

class ColorIcon extends StatelessWidget {
  final Color color;

  final String title;

  ColorIcon({this.color, this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(1.0),
          child: CircleAvatar(
            backgroundColor: color,
            radius: 10,
          ),
          decoration: new BoxDecoration(
            color: Colors.black45, // border color
            shape: BoxShape.circle,
          ),
        ),
        Text(
          title,
          style: TextStyle(color: Colors.white60, fontSize: 12),
        )
      ],
    );
  }
}
