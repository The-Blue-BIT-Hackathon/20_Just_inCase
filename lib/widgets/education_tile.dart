import 'package:flutter/material.dart';

class EducationTile extends StatelessWidget {
  const EducationTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      margin: const EdgeInsets.symmetric( horizontal: 4.0, ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(
            color: Colors.black,
        ),
      ),
      width: mediaQuery.size.width * 0.7,
      height: mediaQuery.size.width * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only( left: 12.0, top: 16.0, bottom: 6.0, ),
            child: Text(
              "title",
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric( horizontal: 12.0, vertical: 4.0, ),
            child: Text(
              "position",
            ),
          ),

          // start date and end date
          Container(
            margin: const EdgeInsets.symmetric( horizontal: 12.0, vertical: 4.0, ),
            child: Text(
              "${"startDate"} - ${ true ? "Current" : "endDate" }",
            ),
          ),
        ],
      ),
    );
  }
}
