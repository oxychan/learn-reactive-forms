import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:latihan_reactive_forms/generated/lib/translations';
import 'package:latihan_reactive_forms/translations/locale_keys.g.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    supportedLocales: const [
      Locale('en'),
      Locale('id'),
    ],
    path: 'assets/translations',
    fallbackLocale: const Locale('id'),
    assetLoader: const CodegenLoader(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final form = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'email': FormControl<String>(
        validators: [Validators.required, Validators.email]),
    'age': FormControl<String>(
        validators: [Validators.required, Validators.number]),
    'address': FormControl<String>(validators: [Validators.required]),
    'password': FormControl<String>(validators: [Validators.required]),
    'passwordConfirmation':
        FormControl<String>(validators: [Validators.required]),
  }, validators: [
    Validators.mustMatch('password', 'passwordConfirmation')
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: Builder(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: const Text('Latihan Ractive Forms')),
          body: SingleChildScrollView(
            child: ReactiveForm(
              formGroup: form,
              child: Column(
                children: <Widget>[
                  ReactiveTextField(
                    formControlName: 'name',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                    validationMessages: {
                      ValidationMessage.required: (error) =>
                          LocaleKeys.field_required.tr()
                    },
                  ),
                  ReactiveTextField(
                    formControlName: 'email',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    validationMessages: {
                      ValidationMessage.required: (error) =>
                          LocaleKeys.field_required.tr(),
                      ValidationMessage.email: (error) =>
                          LocaleKeys.email_required.tr(),
                    },
                  ),
                  ReactiveTextField(
                    formControlName: 'age',
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Age',
                    ),
                    validationMessages: {
                      ValidationMessage.required: (error) =>
                          LocaleKeys.field_required.tr(),
                      ValidationMessage.number: (error) =>
                          'Input must be a number',
                    },
                  ),
                  ReactiveTextField(
                    formControlName: 'address',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                    ),
                    validationMessages: {
                      ValidationMessage.required: (error) =>
                          LocaleKeys.field_required.tr(),
                    },
                  ),
                  ReactiveTextField(
                    formControlName: 'password',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    validationMessages: {
                      ValidationMessage.required: (error) =>
                          LocaleKeys.field_required.tr(),
                    },
                  ),
                  ReactiveTextField(
                    formControlName: 'passwordConfirmation',
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password Confirmation'),
                    obscureText: true,
                    validationMessages: {
                      ValidationMessage.required: (error) =>
                          LocaleKeys.field_required.tr(),
                      ValidationMessage.mustMatch: (error) =>
                          LocaleKeys.password_not_match.tr(),
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        String snackMessage = form.valid
                            ? 'Data submited with no error'
                            : 'Can not submit! Field conatains error';
                        final snackBar = SnackBar(
                          content: Text(snackMessage),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ]
                    .map((widget) => Padding(
                          padding: const EdgeInsets.all(8),
                          child: widget,
                        ))
                    .toList(),
              ),
            ),
          ),
        );
      }),
    );
  }
}
