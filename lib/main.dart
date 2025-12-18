import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary/config/initialized/init.dart' as di;
import 'package:vocabulary/config/theme/app_theme.dart';
import 'package:vocabulary/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:vocabulary/controllers/write_data_cubit/cubit/write_data_cubit.dart';
import 'package:vocabulary/presentation/screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(final BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (final context) => WriteDataCubit()),
        BlocProvider(create: (final context) => ReadDataCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',

        theme: AppTheme.appTheme,

        home: const HomeScreen(),
      ),
    );
  }
}
