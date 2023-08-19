// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class Model extends StatefulWidget {
  const Model({super.key});

  @override
  State<Model> createState() => _ModelState();
}

class _ModelState extends State<Model> {
  int value = 5;
  List names = [
    'B00DQZTS8Q',
    'B00DIFIM36',
    'B001TODUXA',
    'B00CHT6CRC',
    'B0074FGMEW',
    'B001W9Y4PK',
    'B000UN8MKM',
    'B00E9YIFKA',
    'B006SVV6HG',
    'B00000JDF5'
  ];
  List images = [
    'https://m.media-amazon.com/images/I/21ZFfAaiDxL.jpg',
    'https://www.eatthis.com/wp-content/uploads/sites/4/2021/08/wavy-lays-chips.jpg?quality=82&strip=all',
    'https://media.istockphoto.com/id/1371695404/photo/iphone-13-pro-graphite-gray.jpg?s=612x612&w=0&k=20&c=I4kI7FciHSUXGRorunFicLpV_5Bibr2Lj4BZ9hJQnM0=',
    'https://img-api.mac4ever.com/800/0/2a1e4251ca_capture-d-ecran-2022-11-16-a-16-08-12.webp',
    'https://media.istockphoto.com/id/1208634599/photo/apple-airpods-pro-on-a-white-background.jpg?s=170667a&w=0&k=20&c=YBmuAUHb5JhhjFwoppKKO5puBeiZrplxAvlUrypzmas=',
    'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/MD565?wid=2707&hei=1443&fmt=jpeg&qlt=95&.v=1600726119000',
    'https://www.shoecarnival.com/on/demandware.static/-/Sites-scvl-master-catalog/default/dw1c34aacb/125195_320551_1.jpg',
    'https://m.media-amazon.com/images/I/31-QVGIg0pL._SR600%2C315_PIWhiteStrip%2CBottomLeft%2C0%2C35_SCLZZZZZZZ_FMpng_BG255%2C255%2C255.jpg',
    'https://5.imimg.com/data5/SELLER/Default/2022/6/VR/BI/GT/16190546/muscleblaze-biozyme-whey-protein-isolate.jpeg',
    'https://static.zara.net/photos///2022/I/2/2/p/0210/551/999/2/w/1920/0210551999_6_1_1.jpg?ts=1664871864041'
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
