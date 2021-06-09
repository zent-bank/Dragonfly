import 'package:flutter/material.dart';


class MainChartCard extends StatelessWidget {
  const MainChartCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          // boxShadow: [
          //   BoxShadow(
          //     offset: Offset(0,17),
          //     blurRadius: 17,
          //     spreadRadius: -20,
          //     // color: kShadowColor,
          //   )
          // ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(13),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                        alignment: Alignment.center,
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/chart.png"),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

