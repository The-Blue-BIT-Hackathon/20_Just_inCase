class Utils {
  static bool isNumeric(String? s) {
    if(s == null) {
      return false;
    }
    try {
      return (double.parse(s).runtimeType == double || int.parse(s).runtimeType == int);
    }
    catch( e,s ){
      return false;
    }
  }

  static bool isValidEmailAddress( String s ) {
    final validEmailAddress = RegExp(r"^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$");
    return validEmailAddress.hasMatch(s);
  }
}

