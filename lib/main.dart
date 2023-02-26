import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_book/bloc/customer/customer.bloc.dart';
import 'package:tailor_book/bloc/filter/filter_bloc.dart';
import 'package:tailor_book/bloc/form/dynamic_form.bloc.dart';
import 'package:tailor_book/bloc/measure/measure.bloc.dart';
import 'package:tailor_book/bloc/personnel/personnel.bloc.dart';
import 'package:tailor_book/bloc/signin/signin.bloc.dart';
import 'package:tailor_book/bloc/signup/signup.bloc.dart';
import 'package:tailor_book/bloc/user/user.bloc.dart';
import 'package:tailor_book/firebase_options.dart';
import 'package:tailor_book/pages/profil/signin.page.dart';
import 'package:tailor_book/pages/utilities/slide.page.dart';
import 'package:tailor_book/services/user.service.dart';
import 'package:tailor_book/themes/custom.theme.dart';

import 'bloc/measure/measure_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseFirestore.instance.enablePersistence();
  FirebaseFirestore.instance.settings = const Settings(
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    persistenceEnabled: true,
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
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
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
        BlocProvider(
          create: (context) => PersonnelBloc(),
        ),
        BlocProvider(
          create: (context) => FilterBloc(),
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
