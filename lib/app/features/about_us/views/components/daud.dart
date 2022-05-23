part of about_us_screen;

class Daud extends StatelessWidget {
  const Daud({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 80.h,
          width: 80.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              "https://media-exp1.licdn.com/dms/image/C4D03AQHI02ebEmY_MA/profile-displayphoto-shrink_200_200/0/1653234770788?e=1658966400&v=beta&t=V7HBQxnfVMJmATXCiDIpkNA17V944E-aNsm32XYvBIg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 10.sp,
        ),
        Text(
          "Daud K",
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10.sp,
        ),
        Container(
            alignment: Alignment.topLeft,
            // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    const url = 'https://www.facebook.com/iDaudk';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'could not launch $url';
                    }
                  },
                  // onTap: ()=>Utils.openLink(url:"https://www.facebook.com/profile.php?id=100028878831211"),
                  child: FaIcon(FontAwesomeIcons.facebook),
                ),
                SizedBox(width: 10.w),
                InkWell(
                  onTap: () async {
                    const url = 'https://github.com/idaudk';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'could not launch $url';
                    }
                  },
                  // onTap: ()=>Utils.openLink(url:"https://www.facebook.com/profile.php?id=100028878831211"),
                  child: FaIcon(FontAwesomeIcons.github),
                )
              ],
            )),
        SizedBox(
          height: 10.sp,
        ),
      ],
    );
  }
}
