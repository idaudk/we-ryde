part of support_screen;
class CallToAction extends GetView<SupportController> {
  const CallToAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideAnimation(
      begin: Offset(0,500),
      child: Padding(
        padding: EdgeInsets.all(18.r),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff0ec874),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                  onPressed: ()async{
                const url='tel: +92 3409650608';
                if(await canLaunch(url)){
                await launch(url);
                }else {
                throw 'could not launch $url';

                }

              }, icon: Icon(Iconsax.call,color: Colors.white,),
                  label: Text("Call us",style: TextStyle(color: Colors.white ),)),
              Container(
                height: 30.h,
                width: 0.5.w,
                color: Colors.white,
              ),
              TextButton.icon(onPressed: ()async{
                final Uri params = Uri(
                    scheme: 'mailto',
                    path: 'saeedullahafridi17@gmail.com',
                    queryParameters: {
                      'subject': 'Default Subject',
                      'body': 'Default body'
                    }
                );
                String url = params.toString();
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  print('Could not launch $url');
                }

              }, icon: Icon(Iconsax.message,color: Colors.white,),
                  label: Text("Email us",style: const TextStyle(color: Colors.white))),

            ],
          ),
        ),
      ),
    );
  }
}


