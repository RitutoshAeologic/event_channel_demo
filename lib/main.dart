import 'package:event_channel_demo/core/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'core/constants/icon_constants.dart';
import 'core/constants/page_route_constants.dart';
import 'core/constants/string_constants.dart';
import 'core/utils/screen_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConstants.methodEventChannel,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      initialRoute: PageRouteConstants.homeView,
      onGenerateRoute: ScreenRouter.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title:  Text(StringConstants.home),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 100,
                width: 100,
                margin: const EdgeInsets.all(12),
                decoration:  const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppIcons.bgImage),
                        alignment: Alignment.center,
                        fit: BoxFit.fill)),
              )
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.2),
          CustomElevatedButton(title: StringConstants.eventChannel, onTap: (){
            Navigator.pushNamed(
              context,
              PageRouteConstants.eventChannelView,
            );
          },),
          const SizedBox(height: 10),
          CustomElevatedButton(title: StringConstants.methodChannel, onTap: (){
            Navigator.pushNamed(
              context,
              PageRouteConstants.methodChannelView,
            );
          },),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

