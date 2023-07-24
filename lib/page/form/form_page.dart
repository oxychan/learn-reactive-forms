import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../translations/locale_keys.g.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final form = FormGroup(
    {
      'name': FormControl<String>(validators: [Validators.required]),
      'email': FormControl<String>(
          validators: [Validators.required, Validators.email]),
      'age': FormControl<String>(
          validators: [Validators.required, Validators.number]),
      'address': FormControl<String>(validators: [Validators.required]),
      'password': FormControl<String>(validators: [Validators.required]),
      'passwordConfirmation':
          FormControl<String>(validators: [Validators.required]),
    },
    validators: [Validators.mustMatch('password', 'passwordConfirmation')],
  );

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
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
              ValidationMessage.number: (error) => 'Input must be a number',
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
    );
  }
}
