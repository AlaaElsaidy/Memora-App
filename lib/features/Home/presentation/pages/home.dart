import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memora/core/utilies/app_colors.dart';
import 'package:memora/features/Details/presentation/pages/Details.dart';
import '../../../mainScreen/presentation/widget/usedAppBar.dart';
import 'package:device_info/device_info.dart';


class Home extends StatefulWidget {
  final File? imagePreview;

  Home({Key? key, this.imagePreview}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;

  List<String> images = [
    '🍎', '🍎',
    '🍌', '🍌',
    '🍊', '🍊',
    '🍉', '🍉',
    '🍇', '🍇',
    '🍓', '🍓',
    '🍒', '🍒',
    '🍍', '🍍',
    '🍏', '🍏',
  ];
  late List<String> visibleImages;
  late List<bool> flipped;
  late int previousIndex;
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    startGame();
  }
  void startGame() {
    visibleImages = images.toList()..shuffle();
    flipped = List<bool>.filled(images.length, false);
    previousIndex = -1;
  }

  void resetGame() {
    setState(() {
      startGame();
    });
  }

  void flipCard(int index) {
    if (isProcessing || flipped[index]) return;

    setState(() {
      flipped[index] = true;
    });

    if (previousIndex == -1) {
      previousIndex = index;
    } else {
    if (visibleImages[previousIndex] != visibleImages[index]) {
    isProcessing = true;
    Timer(Duration(milliseconds: 1000), () {
    setState(() {
    flipped[previousIndex] = false;
    flipped[index] = false;
    previousIndex = -1;
    isProcessing = false;
    });
    });
    } else {
    previousIndex = -1;
    if (flipped.every((element) => element)) {
      // Check if all cards are flipped
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Good Job!'),
            content: Text('You won the game!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  resetGame();
                },
                child: Text('Play Again'),
              ),
            ],
          );
        },
      );
    }
    }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: Stack(
          children: [
            Container(
              height: 200.h,
              decoration: BoxDecoration(
                color: AppColors.blueColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            Positioned(
              left: 27,
              top: 76,
              bottom: 20,
              child: Row(
                children: [
                  Container(
                    width: 90.w,
                    height: 90.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100.r)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(100.r)),
                      child: widget.imagePreview != null
                          ? Image.file(
                              widget.imagePreview!,
                              fit: BoxFit.fill,
                            )
                          : Image.asset(
                              "assets/images/icon.png",
                              width: 90.w,
                              height: 90.h,
                              fit: BoxFit.fill,
                              color: AppColors.deepgrayColor,
                            ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Text(
                    "Hi, welcome back...",
                    style: TextStyle(
                      color: AppColors.deepgrayColor,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      SizedBox(height: 20.h,),
      Stack(
    children: [

    Container(

    width: 382.w,

    height: 620.h,

    decoration: BoxDecoration(

    color: Colors.grey[200],

    borderRadius: BorderRadius.circular(10),

    ),

    child: GridView.builder(
    padding: EdgeInsets.all(16),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
    childAspectRatio: 1.1, // Adjust the aspect ratio here for larger cards
    ),
    itemCount: images.length,
    itemBuilder: (context, index) {
    return GestureDetector(
    onTap: () {
    flipCard(index);
    },
    child:
    Container( width: 25.w,
    height: 25.h,
    child:
    Card(
    color: flipped[index] ? Colors.white : AppColors.primaryColor,
    child: Center(
    child: Text(
    flipped[index] ? visibleImages[index] : '',
    style: TextStyle(fontSize: 50), // Adjust the font size here for larger cards
    ),
    ),
    ),
    ));
    },
    ),
    ),]),]
    );
  }
}
