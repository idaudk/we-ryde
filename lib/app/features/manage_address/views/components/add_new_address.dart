part of manage_address;
class AddNewAddress extends GetView<ManageAdreesController> {
  const AddNewAddress({Key? key}) : super(key: key);

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
          child: ListTile(
            onTap: (){},
              leading: Icon(Icons.add,color: Colors.white,),
              title: Text("Add New Address",style: TextStyle(color: Colors.white),),
          ),
        ),
      ),
    );
  }
}


