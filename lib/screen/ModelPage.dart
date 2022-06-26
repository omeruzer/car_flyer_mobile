import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../components/bottomNavigationBar.dart';
import '../components/productCard.dart';
import 'CarPage.dart';

class ModelPage extends StatefulWidget {
  var id;
  ModelPage(this.id);

  @override
  State<ModelPage> createState() => _ModelPageState();
}

class _ModelPageState extends State<ModelPage> {
  final placeholder = Opacity(
    opacity: 0,
    child: IconButton(
        onPressed: (() => print('object')), icon: Icon(Icons.abc_outlined)),
  );

  var _model = {};
  var _cars = [];
  var load = false;

  Future fetchBrands() async {
    final urlc = Uri.parse(
        'https://sheltered-scrubland-81136.herokuapp.com/api/model/${widget.id}');
    final response = await http.get(urlc);
    final jsonData = await jsonDecode(response.body);

    setState(() {
      _model = jsonData;
      load = true;
      _cars = _model["cars"];
      print(_cars);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchBrands();
    // Timer(Duration(seconds: 5), () => print(_model['brands'].length));
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
                            "${_model["name"]}",
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
