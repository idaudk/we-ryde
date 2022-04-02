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
              "https://scontent.fpew1-1.fna.fbcdn.net/v/t39.30808-6/274870186_753273965645224_8061862126808114820_n.jpg?_nc_cat=105&ccb=1-5&_nc_sid=174925&_nc_eui2=AeGaM3CdC4HKwhQvHhlrCsU0_GkyKsrUxTH8aTIqytTFMUI34hAvSRxR6PC8DDVACvx_weCUnigPXfEmakZW4iij&_nc_ohc=LGs2Y6EfgYEAX_L8ATh&_nc_ht=scontent.fpew1-1.fna&oh=00_AT9UpA1VtxyE-wDImX8bMIW68YLoT_gr99LxTnD35Wjw0Q&oe=624CD96F",
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
                  // onTap: ()=>Utils.openLink(url:"https://www.facebook.com/profile.php?id=100028878831211"),
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


