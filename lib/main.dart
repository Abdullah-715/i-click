import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/shared/app_shared_prefrences.dart';
import 'features/notifications/presentation/logic/firebase_api.dart';
import 'firebase_options.dart';
import 'observ.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/my_app.dart';

import 'injection/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //?  init the supabase :
  await Supabase.initialize(
      url: 'https://eikjfsmgjqockiigvloy.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVpa2pmc21nanFvY2tpaWd2bG95Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjM3NDUxODEsImV4cCI6MjAzOTMyMTE4MX0.HABrc-bmVUd6oJlljkCpZMlduYs6UcEJZndSYxl1X4c');

  //?  init the di :
  await di.init();
  

  //?  init the firebase :
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //? init the .env file : 
  await dotenv.load(fileName: ".env");
  print(dotenv.env['GOOGLE_CLOUD_CREDENTIALS']); 

  //? bloc observer :
  Bloc.observer = MyBlocObserver();


  //? init notifications :
  await FirebaseApi().initNotifications();


  //?  init the shared prefrences :
  SharedPreferences.getInstance().then(
    (pref) async {
      AppSharedPref.init(pref);

      //?  start app :
      runApp(const MyApp());
    },
  );
}
