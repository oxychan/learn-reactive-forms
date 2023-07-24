import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:latihan_reactive_forms/generated/lib/translations';
import 'package:latihan_reactive_forms/page/form/form_page.dart';
import 'package:latihan_reactive_forms/translations/locale_keys.g.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('id'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('id'),
      assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Latihan Reactive Forms'),
            ),
            body: const SingleChildScrollView(
              child: FormPage(),
            ),
          );
        },
      ),
    );
  }
}
