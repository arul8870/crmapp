import 'package:crmapp/src/login/bloc/login_bloc.dart';
import 'package:crmapp/src/profile/bloc/profile_bloc.dart';
import 'package:crmapp/src/profile/bloc/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutDialog {
  void showDeleteConfirmation(BuildContext context, ProfileBloc bloc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Logout',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          content: Text('Are you sure you want to Logout ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                bloc.add(LogoutProfile());

                context.read<LoginBloc>().add(LogoutEvent());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
