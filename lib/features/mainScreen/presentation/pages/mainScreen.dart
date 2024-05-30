import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memora/features/profiletab/presentation/pages/profile_tab.dart';
import 'package:memora/features/Contacts/presentation/pages/Contacts.dart';
import 'package:memora/features/Home/presentation/pages/home.dart';
import 'package:memora/features/activitiestab/presentation/pages/activities_tab.dart';
import 'package:memora/features/trackingtab/presentation/pages/tracking_tab.dart';
import '../../../../core/utilies/app_colors.dart';
import '../widget/usedBottomNavBar.dart';
import '../widget/usedAppBar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget? appBar;
    FloatingActionButton? floatingActionButton;
    String title = '';

    switch (index) {

      case 1:
        title = 'Activities';
        appBar = UsedAppBar(title: title);
        break;
      case 2:
        title = 'Saved Places';
        appBar = UsedAppBar(title: title);
        break;
      case 3:
        title = 'Contacts List';
        appBar = UsedAppBar(title: title);
        break;
      case 4:
        title = 'Profile';
        appBar = UsedAppBar(title: title);
        break;
    }

    return Scaffold(

      appBar: appBar != null ? appBar : null,
      bottomNavigationBar: UsedBottomNavBar(
        index: index,
        onClick: (value) {
          setState(() {
            index = value;
          });
        },
      ),


      body: IndexedStack(
        index: index,
        children: [
           Home(imagePreview: null,),
          ActivitiesTab(),
          TrackingTab(),
          Contacts(),
           ProfileTab(),

        ],
      ),
    );
  }
}