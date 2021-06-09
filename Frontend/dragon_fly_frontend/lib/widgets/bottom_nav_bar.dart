import 'package:dragon_fly_frontend/main.dart';
import 'package:dragon_fly_frontend/screens/profile_screen.dart';
import 'package:dragon_fly_frontend/screens/trade_screen.dart';
import 'package:dragon_fly_frontend/screens/wallet_screen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class BottomNavBar extends StatelessWidget {
  final String page;
  const BottomNavBar({
    Key? key, 
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isHomeActive = false;
    bool isTradeActive = false;
    bool isWalletActive = false;
    bool isProfileActive = false;
    switch(page){
      case "Home": {
        isHomeActive = true;
      }
      break;
      case "Trade": {
        isTradeActive = true;
      }
      break;
      case "Wallet": {
        isWalletActive = true;
      }
      break;
      case "Profile": {
        isProfileActive = true;
      }
      break;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BottomNavItem(
            svgScr: Icons.home,
            title: "Home",
            press: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen();
                  }),
              );
            },
            isActive: isHomeActive,
          ),
          BottomNavItem(
            svgScr: Icons.monetization_on,
            title: "Trade",
            press: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) {
                    return TradeScreen();
                  }),
              );
            },
            isActive: isTradeActive,
          ),
          BottomNavItem(
            svgScr: Icons.wallet_membership,
            title: "Wallet",
            press: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) {
                    return WalletScreen();
                  }),
              );
            },
            isActive: isWalletActive,
          ),
          BottomNavItem(
            svgScr: Icons.supervised_user_circle,
            title: "Profile",
            press: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) {
                    return ProfileScreen();
                  }),
              );
            },
            isActive: isProfileActive,
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final IconData svgScr;
  final String title;
  final VoidCallback press;
  final bool isActive;
  const BottomNavItem({
    Key? key, 
    required this.svgScr, 
    required this.title, 
    required this.press, 
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(
            svgScr, 
            color: isActive?kActiveIconColor:kTextColor
          ),
          Text(
            title, 
            style: TextStyle(color: isActive?kActiveIconColor:kTextColor),
          )
        ],
      ),
    );
  }
}

