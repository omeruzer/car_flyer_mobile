import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CarPage extends StatefulWidget {
  var id;
  CarPage(this.id);

  @override
  State<CarPage> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  var _car = {};
  var load = true;
  Future fetchCar() async {
    final url = Uri.parse(
        'https://sheltered-scrubland-81136.herokuapp.com/api/car/${widget.id}');

    final response = await http.get(url);
    final jsonData = await jsonDecode(response.body);

    setState(() {
      _car = jsonData;
      load = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchCar();
  }

  @override
  Widget build(BuildContext context) {
    if (this.load) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.red.shade700),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('${_car['name']}'),
          backgroundColor: Colors.red.shade700,
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.red.shade700,
            child: Icon(Icons.call),
            onPressed: () => {
                  print('call'),
                }),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: PageView.builder(
                      itemCount: _car["images"].length,
                      itemBuilder: (context, index) {
                        return Image.network('${_car['images'][index]}');
                      }),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${_car['brand']['name']}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${_car['model']['name']}',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          Text(
                            '${_car['price']} ₺',
                            style: TextStyle(
                                color: Colors.red.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      CarInfo("İlan Sahibi",
                          "${_car['contact_name']} / ${_car['contact_phone']}"),
                      CarInfo("İlan Adı", "${_car['name']}"),
                      CarInfo("Adres",
                          "${_car['city']['city']} / ${_car['district']['district']} / ${_car['street']['street']}"),
                      CarInfo("Kilometre", _car['km']),
                      CarInfo("Yıl", _car['year']['year']),
                      CarInfo("Vites Tipi", "${_car['gear']['name']}"),
                      CarInfo("Yakıt Türü", _car['fuel']['name']),
                      CarInfo("Kasa Tipi", "${_car['case']['name']}"),
                      CarInfo("Çekiş", "${_car['traction']['name']}"),
                      CarInfo("Kimden", "${_car['fromWho']['name']}"),
                      CarInfo("Motor Kapasitesi", _car['engine_capacity']),
                      CarInfo("Motor Gücü", _car['engine_power']),
                      CarInfo("Ort. Yakıt Tüketimi", _car['fuel_cons']),
                      CarInfo("Yakıt Deposu", _car['fuel_tank']),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  Container CarInfo(key, value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: Colors.red.shade300,
          width: 1,
        ),
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${key}',
            style: TextStyle(
                color: Colors.red.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          SizedBox(height: 10),
          Text('${value}'),
        ],
      ),
    );
  }
}
