import 'dart:async';
import 'package:battery/battery.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart'; // Import the generated localization file
import 'home_screen.dart'; // Import your home screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestPermissions(); // Request permissions first
  runApp(const MyApp());
}

Future<void> requestPermissions() async {
  // Request permission to access contacts
  final PermissionStatus status = await Permission.contacts.request();
  if (status.isDenied) {
    // Handle denied status
    print('Permission denied');
  } else if (status.isPermanentlyDenied) {
    // Handle permanent denial
    print('Permission permanently denied');
    // Optionally, suggest the user to go to settings and manually enable the permission
    openAppSettings();
  } else if (status.isGranted) {
    // Proceed with your app logic
    print('Permission granted');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.light;
  final Battery _battery = Battery();
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  Locale _locale = const Locale('en');
  List<Contact> _contacts = [];
  XFile? _profileImage;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    initBattery();
    _fetchContacts();
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    _checkStatus(result);
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      Fluttertoast.showToast(msg: 'Internet Connected!');
    } else {
      Fluttertoast.showToast(msg: 'No Internet Connection!');
    }
  }

  Future<void> initBattery() async {
    _battery.onBatteryStateChanged.listen((BatteryState state) {
      if (state == BatteryState.charging) {
        _battery.batteryLevel.then((level) {
          if (level >= 50) {
            Fluttertoast.showToast(msg: 'Battery level is now $level%');
            // Add your ringtone code here
          }
        });
      }
    });
  }

  Future<void> _fetchContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts.toList();
    });
  }

  void _updateProfileImage(XFile image) {
    setState(() {
      _profileImage = image;
    });
  }

  void _changeTheme(ThemeMode themeMode) {
    setState(() {
      this.themeMode = themeMode;
    });
  }

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      themeMode: themeMode,
      locale: _locale,
      localizationsDelegates: const [
        S.delegate, // Corrected: Use the generated localization delegate
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
      home: HomeScreen(
        onThemeChanged: _changeTheme,
        onLanguageChanged: _changeLanguage,
        contacts: _contacts,
        onUpdateProfileImage: _updateProfileImage,
        profileImage: _profileImage,
      ),
    );
  }
}
