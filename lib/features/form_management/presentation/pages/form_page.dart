import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import '../bloc/form_bloc.dart';
import '../bloc/form_event.dart';
import '../bloc/form_state.dart' as form_state;

@RoutePage()
class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FormBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Form Yönetimi'),
        ),
        body: BlocBuilder<FormBloc, form_state.FormState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Ad',
                      errorText: state.name.error?.toString(),
                    ),
                    onChanged: (value) {
                      context.read<FormBloc>().add(FormNameChanged(value));
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'E-posta',
                      errorText: state.email.error?.toString(),
                    ),
                    onChanged: (value) {
                      context.read<FormBloc>().add(FormEmailChanged(value));
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Telefon',
                      errorText: state.phone.error?.toString(),
                    ),
                    onChanged: (value) {
                      context.read<FormBloc>().add(FormPhoneChanged(value));
                    },
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: state.status.isSubmissionInProgress
                        ? null
                        : () {
                            context.read<FormBloc>().add(const FormSubmitted());
                          },
                    child: state.status.isSubmissionInProgress ? const CircularProgressIndicator() : const Text('Gönder'),
                  ),
                  if (state.status.isSubmissionSuccess)
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        'Form başarıyla gönderildi!',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  if (state.status.isSubmissionFailure)
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        'Form gönderilirken bir hata oluştu!',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
