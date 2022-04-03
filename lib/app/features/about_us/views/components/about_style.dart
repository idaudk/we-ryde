part of about_us_screen;

class CallToAction extends StatelessWidget {
  const CallToAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideAnimation(
      begin: Offset(0, 500),
      child: Padding(
        padding: EdgeInsets.all(18.r),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff0ec874),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 35.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                  child: Text(
                "Rate us on Playstore...",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
