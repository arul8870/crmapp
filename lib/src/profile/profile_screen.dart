import 'package:crmapp/src/common/common.dart';
import 'package:crmapp/src/common/services/services_locator.dart';
import 'package:crmapp/src/profile/bloc/profile_bloc.dart';
import 'package:crmapp/src/profile/bloc/profile_event.dart';
import 'package:crmapp/src/profile/repo/profile_repository.dart';
import 'package:crmapp/src/profile/view/mobile/profile_screen_mobile.dart';
import 'package:crmapp/src/profile/view/tablet/profile_screen_tablet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => ProfileBloc(
            repository: ProfileRepository(
              prefRepo: getIt<PreferencesRepository>(),
            ),
          )..add(InitialProfile()),
      child: Builder(
        builder: (context) {
          context.read<ProfileBloc>().add(InitialProfile());
          return ResponsiveValue<Widget>(
            context,
            defaultValue: const ProfileScreenTablet(),
            conditionalValues: [
              const Condition.equals(
                name: TABLET,
                value: ProfileScreenTablet(),
              ),
              const Condition.smallerThan(
                name: TABLET,
                value: ProfileScreenMobile(),
              ),
            ],
          ).value;
        },
      ),
    );
  }
}
