import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wellbeing/src/bloc/auth/auth_bloc.dart';
import 'package:wellbeing/src/constants/asset.dart';

import 'components/categories.dart';
import 'components/home_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String todayDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 127, 196, 100),
      appBar: AppBar(
        // title: Text('Well-being', style: TextStyle(color: Color.fromRGBO(0, 127, 196, 100),)),
        title: Text('I.P. ONE WELL-BEING',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => {context.read<AuthBloc>().add(AuthEventLogout())},
            icon: Icon(
              Icons.logout,
              color: Colors.white,
              // color: Color.fromRGBO(0, 127, 196, 100),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.040,
                    top: MediaQuery.of(context).size.height * 0.015,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'ยินดีต้อนรับชาว ไอ.พี. วัน',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.030),
                      ),
                    ],
                  ),
                ),
                HomeHeader(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                CategoriesPage(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(248, 200, 73, 1),
                    // boxShadow: [
                    //   BoxShadow(color: Colors.white, spreadRadius: 1),
                    // ],
                  ),
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 15),
                        child: Row(
                          children: [
                            Text(
                              'ข่าว',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.040),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        child: ImageSlideshow(
                          width: MediaQuery.of(context).size.width * 0.86,
                          height: MediaQuery.of(context).size.height * 0.5,
                          initialPage: 0,
                          indicatorColor: Color.fromRGBO(0, 127, 196, 100),
                          indicatorBackgroundColor: Colors.grey,
                          children: [
                            InkWell(
                              onTap: () {
                                // Open URL
                                // launch('https://your-url.com/page1');
                              },
                              child: Image.network(
                                'https://webapps.ip-one.com/news/news01.png',
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width *
                                        0.30,
                                    height: MediaQuery.of(context).size.height *
                                        0.30,
                                    child: Text("ไม่พบรูปภาพ"),
                                  );
                                },
                                fit: BoxFit.contain,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // Open URL
                                // launch('https://your-url.com/page2');
                              },
                              child: Image.network(
                                'https://webapps.ip-one.com/news/news02.png',
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width *
                                        0.30,
                                    height: MediaQuery.of(context).size.height *
                                        0.30,
                                    child: Text("ไม่พบรูปภาพ"),
                                  );
                                },
                                fit: BoxFit.contain,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // Open URL
                                // launch('https://your-url.com/page3');
                              },
                              child: Image.network(
                                'https://webapps.ip-one.com/news/news03.png',
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width *
                                        0.30,
                                    height: MediaQuery.of(context).size.height *
                                        0.30,
                                    child: Text("ไม่พบรูปภาพ"),
                                  );
                                },
                                fit: BoxFit.contain,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // Open URL
                                launch('https://forms.office.com/r/Rr2gJ5XvWg');
                              },
                              child: Image.network(
                                'https://webapps.ip-one.com/news/news04.png',
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width *
                                        0.30,
                                    height: MediaQuery.of(context).size.height *
                                        0.30,
                                    child: Text("ไม่พบรูปภาพ"),
                                  );
                                },
                                fit: BoxFit.contain,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // Open URL
                                // launch('https://your-url.com/page5');
                              },
                              child: Image.network(
                                'https://webapps.ip-one.com/news/news05.png',
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width *
                                        0.30,
                                    height: MediaQuery.of(context).size.height *
                                        0.30,
                                    child: Text("ไม่พบรูปภาพ"),
                                  );
                                },
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                          // onPageChanged: (value) {
                          //   print('Page changed: $value');
                          // },
                          autoPlayInterval: 5000,
                          isLoop: true,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
