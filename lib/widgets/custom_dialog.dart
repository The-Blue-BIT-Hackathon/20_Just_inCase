import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDialog extends StatefulWidget {
  Map<dynamic, dynamic> userDetails;

  CustomDialog({Key? key, required this.userDetails}) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  bool currentlyWorking = false;

  bool companyError = false;
  bool positionError = false;
  bool startDateError = false;
  bool endDateError = false;

  String companyErrorText = "Name cannot be empty";
  String positionErrorText = "Name cannot be empty";
  String startDateErrorText = "Name cannot be empty";
  String endDateErrorText = "Name cannot be empty";

  final TextEditingController companyController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();


  void addExperience( ) {
    showDialog(
        context: context,
        builder: (context) => Container(
          color: Colors.white12,
          alignment: Alignment.center,
          child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>( Colors.grey.shade800),
            strokeWidth: 5,
          ),
        )
    );

    // checking if company is valid
    if( companyController.text.isEmpty ) {
      setState(() {
        companyErrorText = "company cannot be empty";
        companyError = true;
      });
    }
    else {
      setState(() {
        companyError = false;
      });
    }

    // checking if position is valid
    if( positionController.text.isEmpty ) {
      setState(() {
        positionErrorText = "company cannot be empty";
        positionError = true;
      });
    }
    else {
      setState(() {
        positionError = false;
      });
    }

    // checking if startDate is valid
    if( startDateController.text.isEmpty ) {
      setState(() {
        startDateErrorText = "Start Date cannot be empty";
        startDateError = true;
      });
    }
    else {
      setState(() {
        startDateError = false;
      });
    }

    // checking if end Date is valid
    if( endDateController.text.isEmpty ) {
      setState(() {
        endDateErrorText = "End Date cannot be empty";
        endDateError = true;
      });
    }
    else {
      setState(() {
        endDateError = false;
      });
    }

    // returning if any field is invalid
    if( companyError || positionError || startDateError || endDateError ) {
      debugPrint("test");
      Navigator.of(context).pop();
      return;
    }

    debugPrint( widget.userDetails.toString() );

    Map<String, dynamic> details = {
      "user_id" : widget.userDetails['user_id'],
      "company" : companyController.text,
      "position" : positionController.text,
      "start_date" : startDateController.text,
      "end_date" : endDateController.text,
      "isWorking" : currentlyWorking.toString(),
    };

    // sending api request to add experience

  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SizedBox(
      width: mediaQuery.size.width,
      height: mediaQuery.size.height * 0.5,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only( bottom: 16.0, ),
              child: const Text(
                "Add Experience",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),

            // Name text field
            SizedBox(
              width: mediaQuery.size.width,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    height: 30,
                    child: const Text(
                      "Company",
                      style: TextStyle(
                        color: Colors.black ,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      " *",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20 * mediaQuery.textScaleFactor
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: mediaQuery.size.width,
              height: mediaQuery.size.height * 0.065,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 10,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.0)
              ),
              child: TextField(
                onChanged: (value) {
                  if( companyError ) {
                    setState(() {
                      companyError = false;
                    });
                  }
                },
                controller: companyController,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: companyError ? OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2.0
                        ),
                        borderRadius: BorderRadius.circular(10.0)
                    ) : OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2.0
                        ),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(76, 215, 195, 1.0),
                            width: 2.0
                        ),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    hintText: "Enter organization Name",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    )
                ),
              ),
            ),
            if( companyError )
              Container(
                padding: const EdgeInsets.only(top:4.0, left: 8.0),
                width: mediaQuery.size.width,
                child: Text(
                  companyErrorText,
                  style: TextStyle(
                      fontSize: 12 * mediaQuery.textScaleFactor,
                      color: Colors.red
                  ),
                ),
              ),
            const SizedBox(
              height: 10,
            ),

            // Name text field
            SizedBox(
              width: mediaQuery.size.width,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    height: 30,
                    child: const Text(
                      "Position",
                      style: TextStyle(
                        color: Colors.black ,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      " *",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20 * mediaQuery.textScaleFactor
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: mediaQuery.size.width,
              height: mediaQuery.size.height * 0.065,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 10,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.0)
              ),
              child: TextField(
                onChanged: (value) {
                  if( positionError ) {
                    setState(() {
                      positionError = false;
                    });
                  }
                },
                controller: positionController,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: companyError ? OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2.0
                        ),
                        borderRadius: BorderRadius.circular(10.0)
                    ) : OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2.0
                        ),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(76, 215, 195, 1.0),
                            width: 2.0
                        ),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    hintText: "Enter organization Name",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    )
                ),
              ),
            ),
            if( positionError )
              Container(
                padding: const EdgeInsets.only(top:4.0, left: 8.0),
                width: mediaQuery.size.width,
                child: Text(
                  positionErrorText,
                  style: TextStyle(
                      fontSize: 12 * mediaQuery.textScaleFactor,
                      color: Colors.red
                  ),
                ),
              ),
            const SizedBox(
              height: 10,
            ),

            // start date text field
            SizedBox(
              width: mediaQuery.size.width,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    height: 30,
                    child: const Text(
                      "Start Date",
                      style: TextStyle(
                        color: Colors.black ,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      " *",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20 * mediaQuery.textScaleFactor
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: mediaQuery.size.width * 0.6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: mediaQuery.size.width * 0.47,
                    height: mediaQuery.size.height * 0.065,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 10,
                            offset: const Offset(2, 2),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: TextField(
                      onChanged: (value) {
                        if( startDateError ) {
                          setState(() {
                            startDateError = false;
                          });
                        }
                      },
                      controller: startDateController,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: startDateError ? OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 2.0
                              ),
                              borderRadius: BorderRadius.circular(10.0)
                          ) : OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 2.0
                              ),
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(76, 215, 195, 1.0),
                                  width: 2.0
                              ),
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          hintText: "Enter Start Date",
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          )
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime( 2000, 1, 1 ),
                          lastDate:  DateTime.now().add( const Duration( days: 365 * 5 ) ),
                          initialDate: DateTime.now(), // end date would be 5 years from the current time
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                    primary: Color.fromRGBO(76, 215, 195, 1.0),
                                    onPrimary: Colors.white,
                                    onSurface: Colors.black,
                                    onTertiary: Colors.blue
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    primary: Colors.black, // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          }
                      );

                      if( pickedDate != null ) {
                        startDateController.text = DateFormat("dd-MM-yyyy").format(pickedDate);
                      }
                    },
                    icon: Container(
                      margin: const EdgeInsets.only(left: 12.0, ),
                      child: const Icon(
                        Icons.calendar_today_outlined,
                      ),
                    ),
                  )
                ],
              ),
            ),
            if( startDateError )
              Container(
                padding: const EdgeInsets.only(top:4.0, left: 8.0),
                width: mediaQuery.size.width,
                child: Text(
                  startDateErrorText,
                  style: TextStyle(
                      fontSize: 12 * mediaQuery.textScaleFactor,
                      color: Colors.red
                  ),
                ),
              ),
            const SizedBox(
              height: 10,
            ),

            // end date text field
            SizedBox(
              width: mediaQuery.size.width,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    height: 30,
                    child: const Text(
                      "End Date",
                      style: TextStyle(
                        color: Colors.black ,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      " *",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20 * mediaQuery.textScaleFactor
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: mediaQuery.size.width * 0.6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: mediaQuery.size.width * 0.47,
                    height: mediaQuery.size.height * 0.065,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 10,
                            offset: const Offset(2, 2),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: TextField(
                      onChanged: (value) {
                        if( endDateError ) {
                          setState(() {
                            endDateError = false;
                          });
                        }
                      },
                      enabled: !currentlyWorking,
                      controller: endDateController,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: endDateError ? OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 2.0
                              ),
                              borderRadius: BorderRadius.circular(10.0)
                          ) : OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 2.0
                              ),
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(76, 215, 195, 1.0),
                                  width: 2.0
                              ),
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          hintText: "Enter End Date",
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          )
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime( 2000, 1, 1 ),
                          lastDate:  DateTime.now().add( const Duration( days: 365 * 5 ) ),
                          initialDate: DateTime.now(), // end date would be 5 years from the current time
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                    primary: Color.fromRGBO(76, 215, 195, 1.0),
                                    onPrimary: Colors.white,
                                    onSurface: Colors.black,
                                    onTertiary: Colors.blue
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    primary: Colors.black, // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          }
                      );

                      if( pickedDate != null ) {
                        endDateController.text = DateFormat("dd-MM-yyyy").format(pickedDate);
                      }
                    },
                    icon: Container(
                      margin: const EdgeInsets.only(left: 12.0, ),
                      child: Icon(
                        Icons.calendar_today_outlined,
                        color: currentlyWorking ? Colors.grey : Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
            if( endDateError )
              Container(
                padding: const EdgeInsets.only(top:4.0, left: 8.0),
                width: mediaQuery.size.width,
                child: Text(
                  endDateErrorText,
                  style: TextStyle(
                      fontSize: 12 * mediaQuery.textScaleFactor,
                      color: Colors.red
                  ),
                ),
              ),
            const SizedBox(
              height: 10,
            ),

            // i currently work here checkbox
            Row(
              children: [
                Checkbox(
                    value: currentlyWorking,
                    onChanged: (value) {
                      // clearing value of end date textfield
                      endDateController.clear();

                      setState(() {
                        currentlyWorking = !currentlyWorking;
                      });
                    }
                ),
                const Text("I currently work here")
              ],
            ),


            // Adding a Save Button
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(top:20.0),
              child: SizedBox(
                width: mediaQuery.size.width * 0.92,
                height: mediaQuery.size.height * 0.065,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all( const Color.fromRGBO(233, 155, 154, 1) ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        )
                    ),
                    elevation: MaterialStateProperty.all<double>(4.0),
                  ),
                  onPressed: () {
                    // add experience
                    addExperience();
                  },
                  child: Text(
                    "Add Experience",
                    style: TextStyle(
                        fontSize: 20.0 * mediaQuery.textScaleFactor,
                        fontWeight: FontWeight.w900
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
