import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memora/config.dart';
import 'package:memora/config/routes/app_router.dart';
import 'package:memora/core/Location/location.dart';
import 'package:memora/core/components/reusable_components.dart';
import 'package:memora/core/enums/enums.dart';
import 'package:memora/core/utilies/app_colors.dart';
import 'package:memora/features/Details/data/models/userDetailsModel.dart';
import 'package:memora/features/Details/presentation/bloc/details_bloc.dart';
import 'package:memora/features/Details/presentation/widgets/field.dart';
import 'package:memora/features/Details/presentation/widgets/gender.dart';
import 'package:memora/features/Details/presentation/widgets/input.dart';

import '../widgets/mapContainer.dart';

class Details extends StatefulWidget {
  Details({super.key});

  DateTime today = DateTime.now();
  DateTime selectedDate = DateTime.now();
  bool maleSwitch = false;
  bool fmaleSwitch = true;
  Position? position;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  File? image;

  final imagePicker = ImagePicker();
  File? usedImage;

  Future<void> chooseImage() async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = File(pickedImage!.path);
      setState(() {});
    } else {}
  }

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  var detailsBloc = getIt<DetailsBloc>();
  Set<Marker> markers = <Marker>{};
  final Completer<GoogleMapController> mapcontroller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 350.23.h,
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Enter your loved ",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              "One Details ",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(
              height: 50.h,
            ),
            InkWell(
              onTap: () {
                chooseImage();
              },
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    height: 130.h,
                    width: 130.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100.r))),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100.r)),
                        child: image != null
                            ? Image.file(
                                image!,
                                fit: BoxFit.fill,
                              )
                            : Image.asset(
                                "assets/images/icon.png",
                                width: 500,
                                height: 500,
                                fit: BoxFit.fill,
                                color: AppColors.deepgrayColor,
                              )),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.r)),
                          color: Colors.grey),
                      child: Padding(
                        padding: EdgeInsets.all(5.0.r),
                        child: image == null
                            ? Icon(
                                Icons.camera_alt_rounded,
                                size: 35.sp,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                      ))
                ],
              ),
            )
          ],
        ),
        backgroundColor: AppColors.blueColor,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(47.r),
                bottomLeft: Radius.circular(47.r)),
            borderSide: BorderSide(color: Colors.transparent)),
      ),
      body: BlocProvider(
        create: (context) => detailsBloc,
        child: BlocConsumer<DetailsBloc, DetailsState>(
          listener: (context, state) async {
            if (state.status == LocationStatus.failure) {
              if (state.failures?.message == 'noPermission') {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Text('location permission is required'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Geolocator.openAppSettings();
                                },
                                child: Text('Settings'))
                          ],
                        ));
              }
              if (state.failures?.message == 'noService') {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text('location service is required to contenue'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Geolocator.openLocationSettings();
                          },
                          child: Text('Settings'))
                    ],
                  ),
                );
              }
            }
            else if (state.status == LocationStatus.success) {
             var position = state.location;
             widget.position=position;
              markers.add(Marker(
                  markerId: const MarkerId('myPosition'),
                  position: LatLng(
                      position!.latitude, position.longitude)));

              final GoogleMapController controller = await mapcontroller.future;
              await controller.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(position.latitude,
                          position.longitude),
                      zoom: 12)));

            }
            if (state.firestatus == RequestStatus.success) {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutesName.login, (route) => false);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(25.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Field(
                      onClick: () {},
                      controller: name,
                      txt: "Full Name",
                      type: TextInputType.text,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Inputs(
                            txt:
                                widget.selectedDate.toString().substring(0, 10),
                            onClick: () async {
                              widget.selectedDate = (await showDatePicker(
                                  context: context,
                                  firstDate: widget.today,
                                  lastDate:
                                      widget.today.add(Duration(days: 365)),
                                  initialDate: widget.selectedDate))!;
                              if (widget.selectedDate == null) {
                                widget.selectedDate = widget.today;
                              }
                              setState(() {});
                            }),
                        Inputs(
                            txt: widget.fmaleSwitch ? "Female" : "Male",
                            onClick: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Column(
                                    children: [
                                      Gender(
                                          onChange: (value) {
                                            widget.maleSwitch = value;
                                            widget.fmaleSwitch = false;
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                          usedswitch: widget.maleSwitch,
                                          txt: "Male"),
                                      Gender(
                                          onChange: (value) {
                                            widget.maleSwitch = false;
                                            widget.fmaleSwitch = value;
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                          usedswitch: widget.fmaleSwitch,
                                          txt: "Female")
                                    ],
                                  );
                                },
                              );
                            }),
                      ],
                    ),
                    Field(
                        onClick: () {},
                        controller: phone,
                        type: TextInputType.phone,
                        txt: "Phone Number"),
                    MapContainer(
                        mapcontroller: mapcontroller,
                        markers: markers,
                        onClick: () {
                          detailsBloc.add(
                            GetLocation(),
                          );
                        }),
                    useButton(
                        onClick: () {
                          var userDetailsModel = UserDetailsModel(
                              id:,
                              fullName: name.text,
                              date: widget.selectedDate,
                              gender: widget.fmaleSwitch ? "Female" : "Male",
                              phone: phone.text,
                              latitude: widget.position?.latitude.toString(),
                              longitude: widget.position?.longitude.toString(),
                              imgPath: image?.path ?? "");
                          detailsBloc.add(AddDetails(userDetailsModel));
                        },
                        txt: "Submit",
                        context: context,
                        bgcolor: AppColors.primaryColor,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400))
                  ]),
            );
          },
        ),
      ),
    );
  }
}
