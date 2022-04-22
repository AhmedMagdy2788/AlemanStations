import 'dart:developer';

import 'package:aleman_stations/utilities/storage_API/storage_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
// import 'package:print_color/print_color.dart';

import '../theme/app_themes.dart';
import './screens/customers_screen.dart';
import './providers/customers_provider.dart';
// import './models/customer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<String> listOfLangs = ['ar', 'en'];
  String langDir = 'assets/lang/';
  await translator.init(
    languagesList: listOfLangs,
    localeType: LocalizationDefaultType.device,
    assetsDirectory: langDir,
  );
  // final customers = await JsonProviders().getCustomers();
  runApp(LocalizedApp(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => StorageHandler()),
        ChangeNotifierProvider(create: (ctx) => CustomersProvider()),
        ChangeNotifierProvider(create: (ctx) => ThemeProvider()),
      ],
      child: Consumer<StorageHandler>(
        builder: (context, storageHandler, child) {
          return FutureBuilder(
            future: storageHandler.initStorages(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                log('Storage handler initialization state: ${snapshot.data}');
              }
              return Consumer<ThemeProvider>(
                child: const CustomersScreen(),
                builder: (context, themeProvider, child) {
                  final themeMode = themeProvider.themeMode;
                  log(themeMode == ThemeMode.dark ? "dark" : "light");
                  return MaterialApp(
                    title: 'appTitle'.tr(),
                    themeMode: themeMode,
                    theme: AppTheme.appThemeLight(),
                    darkTheme: AppTheme.appThemeDark(),
                    home: (snapshot.connectionState == ConnectionState.done)
                        ? child
                        : const Center(
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                    localizationsDelegates: translator.delegates,
                    locale: translator.activeLocale,
                    supportedLocales: translator.locals(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

// class Home extends StatelessWidget {
//   const Home({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final customersProvider =
//         Provider.of<CustomersProvider>(context, listen: false);
//     Future.delayed(Duration.zero)
//         .then((value) => customersProvider.initCustomer());
//     List<Customer> customers = customersProvider.customers;
//     // for (var customer in customers) {
//     //   print(customer.name);
//     // }
//     return Scaffold(
//       drawer: const Drawer(),
//       appBar: AppBar(
//         title: Text('appTitle'.tr()),
//         // centerTitle: true,
//       ),
//       body: SizedBox(
//         // width: double.infinity,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             const SizedBox(height: 50),
//             Expanded(
//               child: SizedBox(
//                 // height: double.infinity,
//                 // width: double.infinity,
//                 child: ListView.builder(
//                   itemCount: customers.length,
//                   // itemCount: 2,
//                   itemBuilder: (context, index) {
//                     return Text(
//                       // 'textArea'.tr(),
//                       customers[index].name,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(fontSize: 20),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(height: 25),
//             OutlinedButton(
//               onPressed: () {
//                 translator.setNewLanguage(
//                   context,
//                   newLanguage:
//                       translator.activeLanguageCode == 'ar' ? 'en' : 'ar',
//                   remember: true,
//                   restart: true,
//                 );
//               },
//               child: Text('buttonTitle'.tr()),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
/*
import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamController<String> streamController = StreamController();

  void newMessage(int number, String message) {
    final duration = Duration(seconds: number);
    Timer.periodic(duration, (Timer t) => streamController.add(message));
  }

  @override
  void initState() {
    super.initState();
    streamController.stream.listen((messages) => log(messages));
    newMessage(1, 'You got a message!');
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: const Text('Streams Example'),
        ),
      ),
    );
  }
}
*/