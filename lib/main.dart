import 'dart:async';
import 'dart:io';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdv_windows/core/constants/app/app_constants.dart';
import 'package:pdv_windows/core/init/lang/language_manager.dart';
import 'package:pdv_windows/core/init/lang/locale_keys.g.dart';
import 'package:pdv_windows/core/init/navigation/navigation_route.dart';
import 'package:pdv_windows/core/init/navigation/navigation_service.dart';
import 'package:pdv_windows/core/init/notifier/provider_list.dart';
import 'package:pdv_windows/core/init/notifier/theme_notifier.dart';
import 'package:pdv_windows/viewmodel/setup_getIt.dart';
import 'package:provider/provider.dart';


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> main() async {
  runZonedGuarded(
        () async {
      await _init();
      HttpOverrides.global = MyHttpOverrides();
      runApp(
        MultiProvider(
          providers: [...ApplicationProvider.instance.dependItems],
          child: EasyLocalization(
            supportedLocales: LanguageManager.instance.supportedLocales,
            path: ApplicationConstants.LANG_ASSET_PATH,
            startLocale: LanguageManager.instance.defaultLocale,
            child: MyApp()
          ),
        ),
      );
    }, (error, stackTrace) {
      print(error);
      print(stackTrace);
    },
  );
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///INIT
  var path = await getApplicationDocumentsDirectory();
  Hive.init(path.path);
  setupGetIt();
  await EasyLocalization.ensureInitialized();

}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return ConnectionNotifier(
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        connectionNotificationOptions: ConnectionNotificationOptions(
            disconnectedText: LocaleKeys.disconnected_text.tr(),
            connectedText: LocaleKeys.connected_text.tr(),
            alignment: AlignmentDirectional.topCenter,
            height: 50
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: context.watch<ThemeNotifier>().currentTheme,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          onGenerateRoute: NavigationRoute.instance.generateRoute,
          navigatorKey: NavigationService.navigatorKey,
        )
    );
  }
}