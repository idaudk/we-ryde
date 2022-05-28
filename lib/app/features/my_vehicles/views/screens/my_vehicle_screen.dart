library my_vehciles_screen;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:weryde/app/config/themes/app_basic_theme.dart';

import 'package:weryde/app/features/my_vehicles/controllers/my_vehicles_controller.dart';

import '../../../../utils/animations/animations.dart';

part '../components/appbar.dart';
part '../components/banner.dart';
part '../components/add_new_vehicles.dart';
part '../components/bottom_sheet.dart';
part '../components/save_button.dart';

class MyVehiclesScreen extends GetView<MyVehiclesController> {
  MyVehiclesScreen({Key? key}) : super(key: key);
  MyVehiclesController _myVehiclesController = Get.put(MyVehiclesController());
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Color(0xffebf2f8),
          height: MediaQuery.of(context).size.height,
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.h,
              ),
              _AppBar(),
              SizedBox(
                height: 50.h,
              ),
              const _Banner(),
              SizedBox(
                height: 25.h,
              ),
              AddNewVehicles(),
              Expanded(
                child: SlideAnimation(
                  begin: const Offset(0, 300),
                  child: Container(
                    //sconstraints: BoxConstraints.expand(),
                    height: MediaQuery.of(context).size.height - 230.h,
                    padding: EdgeInsets.only(
                      right: 20.w,
                      left: 20.w,
                      top: 1.h,
                    ),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        color: Colors.white),

                    child: StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(MyVehiclesController().auth.currentUser!.uid)
                            .snapshots(), //returns a Stream<DocumentSnapshot>
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator());
                          }
                          var userDocument = snapshot.data;
                          List _vehicleData =
                              List.from(userDocument!['vehicleList']);
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: _vehicleData.length,
                            itemBuilder: (_, index) {
                              return ListTile(
                                trailing: vehicleImage(),
                                title: Text(
                                  _vehicleData[index]['vehicleName'],
                                  style: TextStyle(
                                      fontSize: 16.r,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  _vehicleData[index]['vehilceType'] +
                                      ' | ' +
                                      _vehicleData[index]['vehicleRegNo'] +
                                      ' | ' +
                                      _vehicleData[index]['vehilceType'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10.r),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            },
                          );
                        }),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Container vehicleImage() {
    return Container(
      height: 90.h,
      width: 90.w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          "https://images.pexels.com/photos/3610342/pexels-photo-3610342.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
