import 'package:dragon_fly_frontend/constants.dart';
import 'package:dragon_fly_frontend/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        page: "Profile",
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * 0.15,
            decoration: BoxDecoration(
              color: goldColor,
            ),
          ),
          SafeArea(
            child: Padding(
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
                  SizedBox(height: 50,),
                  Container(
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0,17),
                          blurRadius: 23,
                          spreadRadius: -13,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Text("Profile")
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}

