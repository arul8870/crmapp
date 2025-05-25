import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:crmapp/src/app/app.dart';
import 'package:crmapp/src/base/bloc/base_bloc.dart';
import 'package:crmapp/src/base/repository/base_repository.dart';
import 'package:crmapp/src/common/common.dart';
import 'package:crmapp/src/common/services/services_locator.dart';
import 'package:crmapp/src/login/bloc/login_bloc.dart';
import 'package:crmapp/src/login/repo/login_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await setupLocator();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => getIt<PreferencesRepository>()),
        RepositoryProvider<ApiRepository>(
          create: (context) => getIt<ApiRepository>(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) => LoginBloc(
                  repository: LoginRepository(
                    prefRepo: getIt<PreferencesRepository>(),
                    apiRepo: getIt<ApiRepository>(),
                  ),
                )..add(LoginInitial()),
          ),
          BlocProvider(
            create:
                (context) => BaseBloc(
                  repository: BaseRepository(
                    apiRepo: context.read<ApiRepository>(),
                    prefRepo: context.read<PreferencesRepository>(),
                  ),
                ),
          ),
        ],
        child: const App(),
      ),
    ),
  );
}
