import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:revanced_manager/app/app.locator.dart';
import 'package:revanced_manager/services/crowdin_api.dart';
import 'package:revanced_manager/services/github_api.dart';
import 'package:revanced_manager/services/manager_api.dart';
import 'package:revanced_manager/services/patcher_api.dart';
import 'package:revanced_manager/services/revanced_api.dart';
import 'package:revanced_manager/ui/theme/dynamic_theme_builder.dart';
import 'package:revanced_manager/ui/views/navigation/navigation_view.dart';
import 'package:revanced_manager/utils/environment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_themes/stacked_themes.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;

late SharedPreferences prefs;
Future main() async {
  await ThemeManager.initialise();
  await setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await locator<ManagerAPI>().initialize();
  String apiUrl = locator<ManagerAPI>().getApiUrl();
  await locator<RevancedAPI>().initialize(apiUrl);
  await locator<CrowdinAPI>().initialize();
  bool isSentryEnabled = locator<ManagerAPI>().isSentryEnabled();
  locator<GithubAPI>().initialize();
  await locator<PatcherAPI>().initialize();
  tz.initializeTimeZones();
  prefs = await SharedPreferences.getInstance();

            return null;
          }
        } as BeforeSendCallback?;
    },
    appRunner: () {
      runApp(const MyApp());
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String rawLocale = prefs.getString('language') ?? 'en_US';
    String replaceLocale = rawLocale.replaceAll('_', '-');
    List<String> localeList = replaceLocale.split('-');
    Locale locale = Locale(localeList[0], localeList[1]);

    return DynamicThemeBuilder(
      title: 'ReVanced Manager',
      home: const NavigationView(),
      localizationsDelegates: [
        FlutterI18nDelegate(
          translationLoader: FileTranslationLoader(
            forcedLocale: locale,
            basePath: 'assets/i18n',
            useCountryCode: true,
          ),
          missingTranslationHandler: (key, locale) {
            print(
                '--> Missing translation: key: $key, languageCode: ${locale?.languageCode}');
          },
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
    );
  }
}
