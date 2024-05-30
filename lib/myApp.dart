import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memora/config.dart';
import 'package:memora/features/signUp/presentation/bloc/sign_up_bloc.dart';

import 'config/routes/app_router.dart';
import 'config/theming/app_themeing.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignUpBloc>(),
      child: ScreenUtilInit(
        designSize: Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheming.LightTheme,
          themeMode: ThemeMode.light,
          onGenerateRoute: (settings) => AppRouting.onGenerate(settings),
        ),
      ),
    );
  }
}