import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_book/bloc/customer.bloc.dart';
import 'package:tailor_book/bloc/dynamic_form.bloc.dart';
import 'package:tailor_book/bloc/measure.bloc.dart';
import 'package:tailor_book/bloc/signin.bloc.dart';
import 'package:tailor_book/bloc/signup.bloc.dart';
import 'package:tailor_book/bloc/user.bloc.dart';
import 'package:tailor_book/firebase_options.dart';
import 'package:tailor_book/pages/signin.page.dart';
import 'package:tailor_book/pages/slide.page.dart';
import 'package:tailor_book/services/user.service.dart';
import 'package:tailor_book/themes/custom.theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bool registedStatus = await UserService.getRegistedStatus();
  runApp(MyApp(
    registedStatus: registedStatus,
  ));
}

class MyApp extends StatelessWidget {
  final bool registedStatus;
  const MyApp({
    Key? key,
    this.registedStatus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider(
          create: (context) => SignInBloc(),
        ),
        BlocProvider(
          create: (context) => DynamicFormBloc(),
        ),
        BlocProvider(
          create: (context) => MeasureBloc(),
        ),
        BlocProvider(
          create: (context) => CustomerBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => MeasureAmountBloc(),
        ),
      ],
      child: MaterialApp(
        title: "Tailor Book",
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.themeData,
        home: registedStatus ? const SigninPage() : SlidePage(),
      ),
    );
  }
}
