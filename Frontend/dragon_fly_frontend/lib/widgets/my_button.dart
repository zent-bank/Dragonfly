import 'package:dragon_fly_frontend/constants.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color color;
  final String label;
  final IconData icon;
  final GlobalKey<FormState> formKey;
  
  const MyButton({
    Key? key,
    required this.color,
    required this.label,
    required this.icon, 
    required this.formKey, 
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint){
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
            color: color,
            child: InkWell(
              onTap: () {
                if(formKey.currentState!.validate()){
                  if(label == 'ขาย'){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("")));
                  }else if(label == 'ซื้อ'){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("")));
                  }
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
                        icon, 
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      label,
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
    });
  }
}
