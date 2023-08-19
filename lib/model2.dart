// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class model2 extends StatefulWidget {
  const model2({super.key});

  @override
  State<model2> createState() => _model2State();
}

class _model2State extends State<model2> {
  int value = 5;
  List names = [
    'B00EU9V3YO',
    'B008X9Z528',
    'B00CXP5R6M',
    'B009OZUPUC',
    'B009YQ8BTI'
  ];
  List images = [
    'https://www.lg.com/in/images/monitors/md07534746/gallery/32SP510M-D-02.jpg',
    'https://img.freepik.com/premium-vector/realistic-inkjet-printer-isoalted-white-background_208593-71.jpg',
    'https://media.istockphoto.com/id/910373876/photo/professional-dslr-camera.jpg?s=612x612&w=0&k=20&c=Ax9RZS6zlWHQczrbXeEymuPGMMwe7xIri9-Bf8rKpjk=',
    'https://img.freepik.com/premium-photo/hair-clipper-trimmer-isolated-white-background-with-clipping-path_250899-311.jpg',
    'https://thumbs.dreamstime.com/b/split-air-conditioner-isolated-white-background-clipping-path-90403640.jpg'
  ];
  var decoded;

  Future<List> fetchdata(int value, int userId) async {
    var url = 'http://10.0.2.2:5000/api?user_index=' +
        userId.toString() +
        '&num_of_products=' +
        value.toString();
    http.Response response = await http.get(Uri.parse(url));
    var data = response.body.toString();
    decoded = jsonDecode(data);

    return names;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Recommendations',
          style: TextStyle(color: Colors.black, fontSize: screenWidth / 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Select number of items to be displayed:',
                  style: TextStyle(
                      color: Colors.black, fontSize: screenWidth / 30),
                ),
                SizedBox(
                  width: 10,
                ),
                DropdownButton(
                    items: [
                      DropdownMenuItem(value: 5, child: Text('5')),
                      DropdownMenuItem(value: 10, child: Text('10')),
                      DropdownMenuItem(value: 15, child: Text('15')),
                      DropdownMenuItem(value: 20, child: Text('20')),
                      DropdownMenuItem(value: 25, child: Text('25')),
                    ],
                    value: value,
                    onChanged: (int? newValue) {
                      setState(() {
                        value = newValue!;
                        fetchdata(value, 152);
                      });
                    }),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                  future: fetchdata(value, 152),
                  builder: (context, snapshot) {
                    return GridView.builder(
                        shrinkWrap: true,
                        itemCount: value,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 10,
                              shadowColor: Colors.grey[300],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image(
                                        height: screenHeight / 9,
                                        image: NetworkImage(images[index]),
                                        fit: BoxFit.cover,
                                      ),
                                      Expanded(
                                          child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Text(names[index]))),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Price ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(
                                            flex: 1,
                                          ),
                                          Text(
                                            'Rating : ',
                                            style:
                                                TextStyle(color: Colors.green),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
