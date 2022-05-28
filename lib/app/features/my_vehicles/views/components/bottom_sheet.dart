part of my_vehciles_screen;

class _AddVehicleBottomSheet extends GetView<MyVehiclesController> {
  _AddVehicleBottomSheet({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'SEDAN',
      'label': 'SEDAN',
      // 'icon': Icon(Iconsax.car),
      'textStyle': TextStyle(color: Colors.green),
    },
    {
      'value': 'COUPE',
      'label': 'COUPE',
      // 'icon': Icon(Iconsax.car),
      'textStyle': TextStyle(color: Colors.green),
    },
    {
      'value': 'CONVERTIBLE',
      'label': 'CONVERTIBLE',
      // 'icon': Icon(Iconsax.car),
      'textStyle': TextStyle(color: Colors.green),
    },
    {
      'value': 'SPORT-UTILITY VEHICLE (SUV)',
      'label': 'SPORT-UTILITY VEHICLE (SUV)',
      // 'icon': Icon(Iconsax.car),
      'textStyle': TextStyle(color: Colors.green),
    },
    {
      'value': 'MINIVAN',
      'label': 'MINIVAN',
      // 'icon': Icon(Iconsax.car),
      'textStyle': TextStyle(color: Colors.green),
    },
    {
      'value': 'COUPE',
      'label': 'COUPE',
      'enable': false,
      // 'icon': Icon(Icons.grade),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.arrow_back),
                ),
                Text(
                  'Add Vehicle',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.r),
                ),
                Icon(
                  Icons.arrow_back,
                  color: Colors.transparent,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
            ),
            color: Colors.white,
            child: Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  SelectFormField(
                    type: SelectFormFieldType.dropdown, // or can be dialog
                    //initialValue: '',
                    controller: controller.vehicleTypeController,
                    labelText: 'Vehicle Type',
                    items: _items,
                    onChanged: (val) => print(val),
                    onSaved: (val) => print(val),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextFormField(
                    controller: controller.vehicleNameController,
                    decoration: const InputDecoration(
                      labelText: "Vehicle Name",
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextFormField(
                    controller: controller.vehicleRegNoController,
                    decoration: const InputDecoration(
                      labelText: "Vehicle Reg. Number",
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15.h, left: 10),
                    child: Text('Seats Offering:'),
                  ),
                  GroupButton(
                    controller: controller.vehicleSeatController,
                    isRadio: true,
                    options: GroupButtonOptions(
                      mainGroupAlignment: MainGroupAlignment.start,
                      crossGroupAlignment: CrossGroupAlignment.start,
                      groupRunAlignment: GroupRunAlignment.start,
                      borderRadius: BorderRadius.circular(20),
                      groupingType: GroupingType.wrap,
                      direction: Axis.horizontal,
                      unselectedColor: AppBasicTheme().secondaryColor,
                      spacing: 10,
                      runSpacing: 10,
                      buttonHeight: 50,
                      buttonWidth: 50,
                    ),
                    onSelected: (index, selectedIndex, x) =>
                        print('$index button is selected'),
                    buttons: [
                      "1",
                      "2",
                      "3",
                      "4",
                      "5",
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextFormField(
                    controller: controller.vehicleFacilitiesController,
                    decoration: const InputDecoration(
                      labelText: "Facilities (i.e AC, Extra Luggage, etc)",
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextFormField(
                    controller: controller.vehicleInstructionsController,
                    decoration: const InputDecoration(
                      labelText: "Instructions (i.e No Smoking, pets etc)",
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: const _SaveButton(),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
