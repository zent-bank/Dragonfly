import 'dart:convert';

import 'package:dragon_fly_frontend/constants.dart';
import 'package:dragon_fly_frontend/models/trade_model.dart';
import 'package:dragon_fly_frontend/widgets/bottom_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class TradeScreen extends StatelessWidget {
  const TradeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TradeForm();
  }
}

class TradeForm extends StatefulWidget {

  const TradeForm({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TradeFormState();
  }
  
}


class TradeFormState extends State<TradeForm>{

  final _formKey = GlobalKey<FormState>();
  TradeModel tradeModel = TradeModel();
  String balance = "0.0";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => getBalance());
  }
  
  getBalance() async {
    var response = await http.post(
      Uri.parse('http://localhost:8080/backend/getBalance'),
      body: { 
        'address': '0xd389b5A945670D68681c53fE3C5cCA973CaC53F4',
      }
    );
    print("value ${response.body}");
    Map<String, dynamic> result = jsonDecode(response.body);
    setState(() {
      balance = result['balance'].toString();
    });
  }
  

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Form(
        key: _formKey,
        child: Scaffold(
        bottomNavigationBar: BottomNavBar(
          page: "Trade",
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
                      child: Container(
                        padding: EdgeInsets.all(30),
                        child: Row(
                          children: [
                            Text("จำนวนเหรียญคงเหลือ", style: Theme.of(context).textTheme.headline6!.copyWith(fontFamily: fontFamily, fontWeight: FontWeight.bold)),
                            // SizedBox(width: 10,),
                            Spacer(),
                            Text("$balance DGC" , style: Theme.of(context).textTheme.subtitle1!.copyWith(fontFamily: fontFamily)),
                          ],
                        ),
                      )
                    ),
                    SizedBox(height: 30,),
                    Container(
                      height: size.height * .23,
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
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: TextFormField(
                              onSaved: (newValue) {},
                              onChanged: (value) {
                                tradeModel.coinAmount = double.parse(value);
                              },
                              validator: (value) {
                                if(value == null || value.isEmpty){
                                  return 'กรุณาระบุจำนวนเหรียญ';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "จำนวนเหรียญ",
                                hintText: "0.00",
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: TextFormField(
                              onSaved: (newValue) {},
                              onChanged: (value) {
                                tradeModel.price = double.parse(value);
                              },
                              validator: (value) {
                                if(value == null || value.isEmpty){
                                  return 'กรุณาระบุราคา';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "ราคา",
                                hintText: "0.00",
                              ),
                            ),
                          ),
                          // MyTextFormField(
                          //   labelValidator: 'กรุณาระบุจำนวนเหรียญ',
                          //   labelText: "จำนวนเหรียญ",
                          //   hintText: "0.00",
                          // ),
                          // MyTextFormField(
                          //   labelValidator: 'กรุณาระบุราคา',
                          //   labelText: "ราคา",
                          //   hintText: "0.00",
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),
                    Wrap(
                      spacing: 20,
                      children: <Widget>[
                        LayoutBuilder(builder: (context, constraint){
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(13),
                            child: Container(
                              width: constraint.maxWidth/2 - 10,
                              // padding: EdgeInsets.all(16),
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
                              child: Material(
                                color: Colors.redAccent,
                                child: InkWell(
                                  onTap: () async {
                                    if(_formKey.currentState!.validate()){
                                      final response = await http.post(
                                        Uri.parse('http://localhost:8080/backend/transferToken'),
                                        body: { 
                                          'privateKey': 'db1b2ed2c46b5f55f5d43bdd9b34facd3a038c8ee1fc67bb6cc326d7c3935523', //---- privateKey of account 2 (client sell)
                                          'transferAmount': tradeModel.coinAmount.toString(),
                                          'receiverAddress': '0xB8F29D0517dEbd76f007e6c07C3bCcCD146fF14A'
                                        }
                                      );
                                      print('Response body ${response.body}');
                                      print('Response sttausCode ${response.statusCode.toString()}');
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("สำเร็จ")));
                                      await getBalance();
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          height: 42,
                                          width: 43,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                            )
                                          ),
                                          child: Icon(
                                            Icons.payment, 
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'ขาย',
                                          style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1!
                                                      .copyWith(
                                                        fontFamily: fontFamily, 
                                                        fontWeight: FontWeight.bold, 
                                                        color: Colors.white
                                                      ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                        LayoutBuilder(builder: (context, constraint){
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(13),
                            child: Container(
                              width: constraint.maxWidth/2 - 10,
                              // padding: EdgeInsets.all(16),
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
                              child: Material(
                                color: Colors.green,
                                child: InkWell(
                                  onTap: () async {
                                    if(_formKey.currentState!.validate()){
                                      final response = await http.post(
                                        Uri.parse('http://localhost:8080/backend/transferToken'),
                                        body: { 
                                          'privateKey': '5ceaea5d3e4837dc78b2b555b8850523c189bca6470fac53d606c0f886b52339', //--- privateKey of account 1 (client buy)
                                          'transferAmount': tradeModel.coinAmount.toString(),
                                          'receiverAddress': '0xd389b5A945670D68681c53fE3C5cCA973CaC53F4'
                                        }
                                      );
                                      print('Response body ${response.body}');
                                      print('Response sttausCode ${response.statusCode.toString()}');
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("สำเร็จ")));
                                      await getBalance();
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          height: 42,
                                          width: 43,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                            )
                                          ),
                                          child: Icon(
                                            Icons.monetization_on_outlined, 
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'ซื้อ',
                                          style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1!
                                                      .copyWith(
                                                        fontFamily: fontFamily, 
                                                        fontWeight: FontWeight.bold, 
                                                        color: Colors.white
                                                      ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}

class MyTextFormField extends StatelessWidget {
  final String labelValidator;
  final String labelText;
  final String hintText;
  const MyTextFormField({
    Key? key, 
    required this.labelValidator, 
    required this.labelText, 
    required this.hintText, 
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        onSaved: (newValue) {},
        onChanged: (value) {},
        validator: (value) {
          if(value == null || value.isEmpty){
            return labelValidator;
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}

