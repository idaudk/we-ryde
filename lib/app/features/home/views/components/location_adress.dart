import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_place/google_place.dart';
class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final _startSearchFieldController = TextEditingController();
  final _endSearchFieldController = TextEditingController();
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  // @override
  // void initState() {
  //   //
  //   super.initState();
  //   String apikey="AIzaSyD9YM0CFsOLiX4JIQ8AHv6yioAyoPMTOQw";
  // }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Colors.white,
      ),
      height: 120.h,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.sp,horizontal: 30.sp),
        child: Column(
          children: [
            Expanded(
              child:TextFormField(
                controller: _startSearchFieldController,
                  keyboardType: TextInputType.text,
                  decoration:const InputDecoration(
                    labelText: "Enter Start Location",
                    icon: Icon(Icons.stop,color: Color(0xff0FC874),),
                    filled: false,
                    focusedBorder: UnderlineInputBorder(),
                    enabledBorder: UnderlineInputBorder(),
                    errorBorder: UnderlineInputBorder(),
                    focusedErrorBorder: UnderlineInputBorder(),
                  ),
                onChanged: (value) {
                  if (value.isNotEmpty) {

                  } else {
                    if (predictions.length > 0 && mounted) {
                      setState(() {
                        predictions = [];
                      });
                    }
                  }
                },
                ),
              ),
            Expanded(
              child:TextFormField(
                controller: _endSearchFieldController,
                  keyboardType: TextInputType.text,
                  decoration:const InputDecoration(
                    labelText: "Enter Drop Location",
                    icon: Icon(Icons.location_on,color: Colors.red,),
                    filled: false,
                    focusedBorder: UnderlineInputBorder(),
                    enabledBorder: UnderlineInputBorder(),
                    errorBorder: UnderlineInputBorder(),
                    focusedErrorBorder: UnderlineInputBorder(),

                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
