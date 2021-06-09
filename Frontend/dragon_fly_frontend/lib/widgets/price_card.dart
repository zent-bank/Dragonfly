import 'package:flutter/material.dart';

import '../constants.dart';


class PriceCard extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final String updateDateTime;
  final String price;
  const PriceCard({
    Key? key, 
    required this.title, 
    required this.backgroundColor, 
    required this.updateDateTime,
    required this.price, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: Container(
            width: constraint.maxWidth/2 - 10, // constraint.maxWidth provide us the available width for this widget
            // padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor,
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
            child: Material(
              color: Colors.transparent,
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        title, 
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6!.copyWith(fontFamily: fontFamily, fontWeight: FontWeight.bold, fontSize: 23),
                      ),
                      Text(
                        updateDateTime,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6!.copyWith(fontFamily: fontFamily, fontSize: 12, fontStyle: FontStyle.italic),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 30),
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: Text(
                          price,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6!.copyWith(fontFamily: fontFamily, fontWeight: FontWeight.bold),
                        )
                      ),
                    ],
                  ),
                ),
            ),
          ),
        );
      }
    );
  }
}