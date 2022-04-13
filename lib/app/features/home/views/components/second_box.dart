import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class box2 extends StatefulWidget {
  @override
  State<box2> createState() => _box2State();
}

class _box2State extends State<box2> {
  // TabController? _tabController;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color(0xff0ec874),
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.0))),
      height: 200.h,
      width: double.infinity,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 130.sp, left: 15.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.sp),
              color: const Color(0xff3FD390),
            ),
            height: 50.h,
            width: 330.w,
            child: TabBar(
              onTap: (index){
                setState(() {
                  _currentIndex = index;
                });
              },
              indicatorColor: Colors.red,
              padding: EdgeInsets.all(4),
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              tabs: [
                Tab(
                  child: Row(children: [
                    Icon(Icons.car_repair,
                        color: _currentIndex == 0
                            ? Color(0xff0FC874)
                            : Color(0xff427953)),
                    SizedBox(width: 10,),
                    Text("Find Pool",style: TextStyle(fontWeight: FontWeight.bold,
                        color: _currentIndex == 0
                            ? Color(0xff0FC874)
                            : Color(0xff427953)), ),
                  ]),

                ),
                Tab(
                  child: Row(children: [
                    Icon(Icons.directions_car_outlined,
                        color: _currentIndex == 1
                            ? Color(0xff0FC874)
                            : Color(0xff427953)),
                    SizedBox(width: 10,),
                    Text("Offer Pool",style: TextStyle(fontWeight: FontWeight.bold,
                        color: _currentIndex == 1
                            ? Color(0xff0FC874)
                            : Color(0xff427953)), ),
                  ]),

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


//