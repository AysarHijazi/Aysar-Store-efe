import 'package:shared_preferences/shared_preferences.dart';

class SPHelper{
  ///  This two lines to crate singlton class
  SPHelper._();
  static SPHelper spHelper = SPHelper._();

  SharedPreferences? sharedPreferences;

  String ifFirstShowTitle = 'ifFirstShow';

  Future initSharedPreferences()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  bool isNew(){
   bool result = sharedPreferences?.getBool(ifFirstShowTitle) ?? true;
   return result;
  }

  Future storeUserStatus() async{
    await sharedPreferences?.setBool(ifFirstShowTitle, false);
  }
}
