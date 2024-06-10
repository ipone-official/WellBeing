import 'package:flutter/material.dart';
import 'package:wellbeing/src/Pages/app_routes.dart';
import 'package:wellbeing/src/app.dart';
import 'package:wellbeing/src/constants/asset.dart';
import 'package:wellbeing/src/widgets/custom_flushbar.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class Items {
  String? title;
  String? subtitle;
  String? event;
  String? img;

  Items({this.title, this.subtitle, this.event, this.img});
}

Items Runner = new Items(
    title: "Run to The Moon",
    subtitle: "วิ่งให้ถึงดวงจันทร์",
    event: AppRoute.record,
    img: Asset.NewLogoRunnerImage);

Items commingsoon = new Items(
    title: "พบกันเร็ว ๆ นี้", subtitle: "", event: '', img: Asset.App3);

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    List<Items> _menu = [Runner, commingsoon];
    Color color = Color(0xFFFFECDF);
    return GridView.count(
      shrinkWrap: true,
      childAspectRatio: 1.0,
      padding: EdgeInsets.all(3),
      crossAxisCount: 3,
      crossAxisSpacing: 3,
      mainAxisSpacing: 3,
      children: _menu.map((data) {
        return GestureDetector(
            onTap: () {
              if (data.event == '') {
                return CustomFlushbar.showWarning(navigatorState.currentContext!,
                    message: 'พบกันเร็ว ๆ นี้');
              }
              Navigator.pushNamed(context, data.event.toString());
            },
            child: Container(
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox.fromSize(
                          size: Size.fromRadius(
                              MediaQuery.of(context).size.width *
                                  0.10), // Image radius
                          child: Image.asset(
                            data.img.toString(),
                          ))),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text(
                    '${data.title}',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.030),
                  ),
                  Text(
                    '${data.subtitle}',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.023),
                  ),
                ],
              ),
            )
            );
      }).toList(),
    );
  }
}
