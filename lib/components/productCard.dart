import 'package:flutter/material.dart';

Container ProductCard(img, brand, model, year, km, city, price) {
  return Container(
    margin: EdgeInsets.all(10),
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(20),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.black54, blurRadius: 2.0, offset: Offset(0.0, 0.1))
      ],
    ),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network('${img}'),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${brand}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${model} - ${year} - ${km} km',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Text(
                    '${city}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Text(
                '${price} ₺',
                style: TextStyle(
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )
            ],
          ),
        )
      ],
    ),
  );
}
