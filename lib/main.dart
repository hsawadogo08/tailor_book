import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_book/bloc/signup.bloc.dart';
import 'package:tailor_book/firebase_options.dart';
import 'package:tailor_book/pages/welcome.page.dart';
import 'package:tailor_book/themes/custom.theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignUpBloc(),
        ),
      ],
      child: MaterialApp(
        title: "Tailor Book",
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.themeData,
        home: const WelcomePage(),
      ),
    );
  }
}
