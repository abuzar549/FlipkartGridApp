import 'package:flipkart_app/model.dart';
import 'package:flipkart_app/model2.dart';
import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int user = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(
                        image: NetworkImage(
                            'https://www.freepnglogos.com/uploads/flipkart-logo-png/flipkart-inventory-management-system-zap-inventory-1.png')),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        if (user == 1) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Model()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => model2()));
                        }
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'My Recommendations',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (user == 1)
                            user = 2;
                          else
                            user = 1;
                        });
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              '      Switch User   ' + user.toString() + '    ',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    )
                  ],
                ),
              ),
            )),
        body: Column(
          children: [
            Container(
              // height: MediaQuery.of(context).size.height,
              child: Image(
                  image: NetworkImage('https://i.ibb.co/93PCSK4/IMG-9409.jpg')),
            ),
          ],
        ),
      ),
    );
  }
}
