import 'package:base_flutter/base/data/db/app_dao.dart';
import 'package:base_flutter/base/data/storage/sp_utils.dart';
import 'package:base_flutter/data/user.dart';
import 'package:base_flutter/screen/account/account_cubit.dart';
import 'package:base_flutter/screen/account/account_screen.dart';
import 'package:base_flutter/screen/account/account_state.dart';
import 'package:base_flutter/screen/home/home_cubit.dart';
import 'package:base_flutter/screen/home/home_screen.dart';
import 'package:base_flutter/screen/home/home_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'base/data/db/db_helper.dart';
import 'base/navigation_service.dart';
import 'base/service_locator.dart';
import 'constant/constant_color.dart';
import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  final database =
      await $FloorDatabaseHelper.databaseBuilder('school_online.db').build();
  var sp = await SharePreferenceRepository.instance;
  final dao = database.appDao;
  runApp(MyApp(sp, dao));
}

class MyApp extends StatelessWidget {
  SharePreferenceRepository sp;

  AppDao dao;

  // This widget is the root of your application.

  MyApp(this.sp, this.dao);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: ConstColor.colorPrimary, // navigation bar color
      statusBarColor: ConstColor.colorPrimary, // status bar color
      statusBarBrightness: Brightness.light,
    ));
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SharePreferenceRepository>.value(
          value: sp,
        ),
        RepositoryProvider<AppDao>.value(
          value: dao,
        ),
      ],
      child: GestureDetector(
        onTap: () {
          if (WidgetsBinding.instance != null) {
            WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
          }
        },
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          navigatorKey: locator<NavigationService>().navigatorKey,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: Locale('vi'),
          theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
              fontFamily: 'Inter',
              // This makes the visual density adapt to the platform that you run
              // the app on. For desktop platforms, the controls will be smaller and
              // closer together (more dense) than on mobile platforms.
              visualDensity: VisualDensity.adaptivePlatformDensity,
              appBarTheme: Theme.of(context).appBarTheme.copyWith(
                    backgroundColor: ConstColor.colorPrimary,
                    brightness: Brightness.light,
                    titleSpacing: 0,
                  )),
          home: BlocProvider(
            create: (context) => AccountCubit(context, AccountState(message: 'Tài khoản')),
            child: AccountScreen(),
          ),
          // => change with start screen
          onGenerateRoute: onGenerateRoute,
        ),
      ),
    );
  }

  //sample page route
  // CupertinoPageRoute(
  //       builder: (context) => BlocProvider(
  //         create: (context) => BaseBloc(),
  //         child: Container(),
  //       ),
  //     );

  Route? onGenerateRoute(RouteSettings settings) {
    Route? page;
    switch (settings.name) {
      case HomeScreen.SCREEN_NAME:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => HomeCubit(
              context,
              HomeState(settings.arguments as User),
            ),
            child: HomeScreen(),
          ),
        );
        break;
    }
    return page;
  }
}
