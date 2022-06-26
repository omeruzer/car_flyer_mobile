import 'dart:convert';
import 'package:tete/screen/CarPage.dart';

import '../components/productCard.dart';
import './CategoryPage.dart';
import '../components/topCard.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final url =
      Uri.parse('https://sheltered-scrubland-81136.herokuapp.com/api/category');
  var _category = [];

  Future fetchCategory() async {
    final response = await http.get(url);
    final jsonData = await jsonDecode(response.body) as List;

    setState(() {
      _category = jsonData;
    });
  }

  final urlc =
      Uri.parse('https://sheltered-scrubland-81136.herokuapp.com/api/car');
  var _cars = [];

  Future fetchCar() async {
    final response = await http.get(urlc);
    final jsonData = await jsonDecode(response.body) as List;

    setState(() {
      _cars = jsonData;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchCategory();
    fetchCar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            // Kırmızı
            Container(
              color: Colors.red.shade700,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('ArabaSat',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(
                              '25/06/2022',
                              style: TextStyle(
                                color: Colors.red.shade100,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.red.shade400,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.filter_alt_sharp,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 20, bottom: 10),
                    child: Row(
                      children: const [
                        Text('Kategoriler',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, bottom: 10),
                    height: 60,
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _category.length,
                            itemBuilder: (BuildContext context, int index) {
                              final cat = _category[index];
                              return GestureDetector(
                                onTap: (() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CategoryPage(cat["_id"])));
                                }),
                                child: TopCard(cat["name"]),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: _cars.map((e) {
                return GestureDetector(
                  onTap: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CarPage(e['_id'])));
                  }),
                  child: ProductCard(
                    e['images'][0],
                    e['brand']["name"],
                    e['model']["name"],
                    e['year']["year"],
                    e['km'],
                    e['city']["city"],
                    e['price'],
                  ),
                );
              }).toList(),
            ),
          ]),
        ),
      ),
    );
  }
}
