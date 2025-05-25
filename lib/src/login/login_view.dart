import 'package:crmapp/src/common/utils/utils.dart';
import 'package:crmapp/src/login/bloc/login_bloc.dart';
import 'package:crmapp/src/login/view/desktop/login_page_desktop.dart';
import 'package:crmapp/src/login/view/mobile/login_page_mobile.dart';
import 'package:crmapp/src/login/view/tablet/login_page_tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:logger/logger.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final log = Logger();

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.loggedIn) {
          log.d("LoginStatusLoginStatus :: ${state.status}");
          context.goNamed('/base');
        }

        if (state.status == LoginStatus.error) {
          ToastUtil.showErrorToast(context, state.message);
          context.goNamed('login');
        }
      },
      builder: (context, state) {
        return ResponsiveValue<Widget>(
          context,
          defaultValue: const LoginPageDesktop(),
          conditionalValues: [
            const Condition.equals(name: TABLET, value: LoginPageTablet()),
            const Condition.smallerThan(name: MOBILE, value: LoginPageMobile()),
          ],
        ).value!;
      },
    );
  }
}
