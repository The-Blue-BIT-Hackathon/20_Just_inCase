import 'package:flutter/material.dart';

class PrepSubjectTile extends StatelessWidget {
  const PrepSubjectTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      margin: const EdgeInsets.symmetric( horizontal: 12.0,vertical: 10.0 ),
      width: mediaQuery.size.width,
      height: mediaQuery.size.height * 0.2,
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage(
                "assets/images/img3.png"
              ),
              fit: BoxFit.fill
          ),
          borderRadius: BorderRadius.circular( 20.0,),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade600,
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(-5,0),
            ),
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(5,0),
            )
          ]
      ),
    );
  }
}
