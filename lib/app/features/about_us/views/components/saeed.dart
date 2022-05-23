part of about_us_screen;

class Saeed extends StatelessWidget{
  const Saeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Container(
          height: 80.h,
          width: 80.w,
          child: ClipRRect(
            borderRadius:
            BorderRadius.circular(12),
            child: Image.network(
              "https://avatars.githubusercontent.com/u/102222524?v=4",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 10.sp,
        ),
        Text(
          "Saeed Afridi",
          style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.sp,),
        Container(
            alignment: Alignment.topLeft,
            // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
            child: Row(
              children: [
                InkWell(
                  onTap : ()async{
                    const url='https://www.facebook.com/saeedullahafridy1/';
                    if(await canLaunch(url)){
                      await launch(url);
                    }else {
                      throw 'could not launch $url';

                    }},
                  child: FaIcon(FontAwesomeIcons.facebook),
                ),
                SizedBox(width: 10.w),
                InkWell(
                  onTap : ()async{
                    const url='https://github.com/saeedafridi1';
                    if(await canLaunch(url)){
                      await launch(url);
                    }else {
                      throw 'could not launch $url';

                    }},
                  // onTap: ()=>Utils.openLink(url:"https://www.facebook.com/profile.php?id=100028878831211"),
                  child: FaIcon(FontAwesomeIcons.github),
                )

              ],
            )

        ),
        SizedBox(
          height: 10.sp,
        ),
      ],
    );
  }
}


