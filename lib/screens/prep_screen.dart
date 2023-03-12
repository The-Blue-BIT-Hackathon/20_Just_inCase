import 'package:flutter/material.dart';
import 'package:job_search_app/widgets/prep_subject_tile.dart';


class PrepScreeen extends StatelessWidget {
  const PrepScreeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
        body: Container(
          height: mediaQuery.size.height,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: const [
                SizedBox(
                  height: 10,
                ),

                PrepSubjectTile(),
                PrepSubjectTile(),
                PrepSubjectTile(),
                PrepSubjectTile(),

                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        )
    );
  }
}
