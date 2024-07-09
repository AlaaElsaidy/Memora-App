import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memora/core/utilies/app_colors.dart';

import '../../../../core/Firebase/FirebaseFunctions.dart';

class Home extends StatefulWidget {
  final File? imagePreview;

  Home({Key? key, this.imagePreview, this.userUID}) : super(key: key);
  String? userUID;
  @override
  State<Home> createState() => _HomeState(imagePreview: imagePreview);
}

class _HomeState extends State<Home> {
  int index = 0;
  File? imagePreview;
  var getdata = FirebaseFunctions();

  _HomeState({this.imagePreview});

  List<String> images = [
    '🍎',
    '🍎',
    '🍌',
    '🍌',
    '🍊',
    '🍊',
    '🍉',
    '🍉',
    '🍇',
    '🍇',
    '🍓',
    '🍓',
    '🍒',
    '🍒',
    '🍍',
    '🍍',
    '🍏',
    '🍏',
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

  void updateImagePreview(File newImage) {
    setState(() {
      imagePreview = newImage;
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
        Timer(const Duration(milliseconds: 1000), () {
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
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Good Job!'),
                content: const Text('You won the game!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      resetGame();
                    },
                    child: const Text('Play Again'),
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
    return Scaffold(
      body: StreamBuilder(
        stream: getdata.getAllusers(widget.userUID ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Something Wrong."));
          }
          var data = snapshot.data?.docs.map((e) => e.data()).toList() ?? [];

          return Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 200.h,
                    decoration: BoxDecoration(
                      color: AppColors.blueColor,
                      borderRadius: const BorderRadius.only(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(100.r)),
                          ),
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100.r)),
                              child: data[0].imgPath == ""
                                  ? Image.asset(
                                      "assets/images/icon.png",
                                      // width: 500,
                                      // height: 500,
                                      fit: BoxFit.cover,
                                      color: AppColors.deepgrayColor,
                                    )
                                  : Image.file(
                                      File(data[0].imgPath),
                                      fit: BoxFit.fill,
                                    )),
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
              SizedBox(height: 20.h),
              Expanded(
                child: Container(
                  width: 382.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1.1,
                    ),
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          flipCard(index);
                        },
                        child: SizedBox(
                          width: 25.w,
                          height: 25.h,
                          child: Card(
                            color: flipped[index]
                                ? Colors.white
                                : AppColors.primaryColor,
                            child: Center(
                              child: Text(
                                flipped[index] ? visibleImages[index] : '',
                                style: const TextStyle(fontSize: 50),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
