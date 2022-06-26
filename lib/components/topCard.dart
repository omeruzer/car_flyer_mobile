import 'package:flutter/material.dart';

Container TopCard(name) {
  return Container(
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.red.shade400,
      borderRadius: BorderRadius.circular(15),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.red.shade900,
            blurRadius: 1.0,
            offset: Offset(0.0, 0.1))
      ],
    ),
    child: Text(
      "${name}",
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
    // Column(
    //   children: [
    //     Text(
    //       "${name}",
    //       style: TextStyle(color: Colors.white, fontSize: 18),
    //     ),
    //   ],
    // ),
  );
}
