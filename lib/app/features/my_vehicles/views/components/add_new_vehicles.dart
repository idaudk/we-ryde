part of my_vehciles_screen;
class AddNewVehicles extends GetView<MyVehiclesController> {
  const AddNewVehicles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideAnimation(
      begin: const Offset(0,500),
      child: Padding(
        padding: EdgeInsets.all(18.r),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xff0ec874),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
          child: ListTile(
            onTap: (){},
            leading: const Icon(Icons.add,color: Colors.white,),
            title: const Text("Add New Vehicle",style: TextStyle(color: Colors.white),),
          ),
        ),
      ),
    );
  }
}


