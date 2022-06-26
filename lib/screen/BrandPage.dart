import 'package:flutter/material.dart';
import 'package:tete/screen/CategoryPage.dart';
import 'package:tete/screen/HomePage.dart';
import 'package:tete/screen/ModelPage.dart';
import '../components/bottomNavigationBar.dart';
import '../components/productCard.dart';
import '../components/topCard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'CarPage.dart';

class BrandPage extends StatefulWidget {
  var id;
  BrandPage(this.id);
  @override
  State<BrandPage> createState() => _BrandPageState();
}

final placeholder = Opacity(
  opacity: 0,
  child: IconButton(
      onPressed: (() => print('object')), icon: Icon(Icons.abc_outlined)),
);

class _BrandPageState extends State<BrandPage> {
  var _models = {};
  var _cars = [];
  var load = false;

  Future fetchModels() async {
    final urlc = Uri.parse(
        'https://sheltered-scrubland-81136.herokuapp.com/api/brand/${widget.id}');
    final response = await http.get(urlc);
    final jsonData = await jsonDecode(response.body);

    setState(() {
      _models = jsonData;
      load = true;
      _cars = _models["cars"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchModels();
    // Timer(Duration(seconds: 5), () => print(_brands['brands'].length));
  }

  @override
  Widget build(BuildContext context) {
    if (!this.load) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.red.shade700),
          ),
        ),
      );
    } else {
      return Scaffold(
        bottomNavigationBar: BottomNavBar(placeholder: placeholder),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red.shade700,
          onPressed: ((() {
            print('asd');
          })),
          tooltip: 'Increment Counter',
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                          GestureDetector(
                            onTap: (() {
                              Navigator.pop(context);
                            }),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          Text(
                            "${_models["name"]}",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
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
                          Text('Modeller',
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
                              itemCount: _models['models'].length,
                              itemBuilder: (BuildContext context, int index) {
                                final model = _models['models'][index];
                                return GestureDetector(
                                  onTap: (() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ModelPage(model["_id"])));
                                  }),
                                  child: TopCard(model['name']),
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
}
