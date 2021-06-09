import 'package:dragon_fly_frontend/widgets/bottom_nav_bar.dart';
import 'package:dragon_fly_frontend/widgets/main_chart_card.dart';
import 'package:dragon_fly_frontend/widgets/news_card.dart';
import 'package:dragon_fly_frontend/widgets/price_card.dart';
import 'package:flutter/material.dart';
import 'package:dragon_fly_frontend/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dragonfly',
      theme: ThemeData(
        fontFamily: fontFamily,
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size; // this gonna give us total height and width of our device
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        page: "Home",
      ),
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of out total height
            height: size.height * 0.35,
            decoration: BoxDecoration(
              color: goldColor,
            ),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height:30,),
                  Text(
                    "Dragonfly system",
                    style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.red[700],
                                ),
                  ),
                  // SearchBar(),
                  SizedBox(height: 30,),
                  MainChartCard(),
                  SizedBox(height: 30,),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: <Widget>[
                      PriceCard(
                        title: "ราคา DGC",
                        backgroundColor: goldColor,
                        updateDateTime: "ล่าสุด 07/06/2021 17:30",
                        price: "28,800",
                      ),
                      PriceCard(
                        title: "ราคาทองแท่ง",
                        backgroundColor: Colors.red.shade400,
                        updateDateTime: "ล่าสุด 07/06/2021 16:00",
                        price: "27,800",
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "ข่าว",
                    style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[700],
                                ),
                  ),
                  NewsCard()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

