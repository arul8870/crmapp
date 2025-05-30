import 'package:crmapp/src/loigin_firebase/bloc/login_firebase_bloc.dart';
import 'package:crmapp/src/loigin_firebase/view/login_firebase_page_desktop.dart';
import 'package:crmapp/src/loigin_firebase/view/login_firebase_page_mobile.dart';
import 'package:crmapp/src/loigin_firebase/view/login_firebase_page_tablet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginFirebasePage extends StatelessWidget {
  const LoginFirebasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginFirebaseBloc, LoginFirebaseState>(
      listener: (context, state) {
        if (state.status == LoginFirebaseStatus.loggedIn) {
          // Navigate after successful login
          context.go('/base');
        } else if (state.status == LoginFirebaseStatus.failure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final responsiveWidget = ResponsiveValue<Widget>(
          context,
          defaultValue: const LoginFirebasePageDesktop(),
          conditionalValues: [
            const Condition.equals(
              name: MOBILE,
              value: LoginFirebasePageMobile(),
            ),
            const Condition.equals(
              name: TABLET,
              value: LoginFirebasePageTablet(),
            ),
          ],
        ).value!;

        return responsiveWidget;
      },
    );
  }
}
