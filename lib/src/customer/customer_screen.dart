import 'package:crmapp/src/common/common.dart';
import 'package:crmapp/src/common/services/services_locator.dart';
import 'package:crmapp/src/customer/bloc/customer_bloc.dart';

import 'package:crmapp/src/customer/repo/customer_repository.dart';
import 'package:crmapp/src/customer/view/mobile/customer_screen_mobile.dart';
import 'package:crmapp/src/customer/view/tablet/customer_screen_tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => CustomerBloc(
            repository: CustomerRepository(
              prefRepo: getIt<PreferencesRepository>(),
              apiRepo: getIt<ApiRepository>(),
            ),
          )..add(InitializeCustomer()),
      child: Builder(
        builder: (context) {
          context.read<CustomerBloc>().add(InitializeCustomer());
          return ResponsiveValue<Widget>(
            context,
            defaultValue: const CustomerScreenTablet(),
            conditionalValues: [
              const Condition.equals(
                name: TABLET,
                value: CustomerScreenTablet(),
              ),
              const Condition.smallerThan(
                name: TABLET,
                value: CustomerScreenMobile(),
              ),
            ],
          ).value;
        },
      ),
    );
  }
}
