import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:project_decision/filter-controller.dart';
import 'package:project_decision/screens/AddFood/add-food.dart';
import 'package:project_decision/screens/CategoryPage/category-page.dart';
import 'package:project_decision/screens/Home/home.dart';
import 'package:project_decision/screens/Start/start.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.put(FilterController());
      }),
      getPages: [
        GetPage(name: "/start", page: () => Start()),
        GetPage(name: "/home", page: () => Home()),
        GetPage(name: "/add-food", page: () => AddFood()),
        GetPage(name: "/category", page: () => CategoryPage()),
      ],
      initialRoute: "/start",
    );
  }
}
