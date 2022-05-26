part of home_view;

class OfferPool extends GetView<HomeController> {
  OfferPool({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'Carolla',
      'label': 'Toyota Carolla Xli',
      'icon': Icon(Iconsax.car),
      'textStyle': TextStyle(color: Colors.green),
    },
    {
      'value': 'Mazda',
      'label': 'Mazda RX8',
      'icon': Icon(Iconsax.car),
      'textStyle': TextStyle(color: Colors.green),
    },
    {
      'value': 'starValue',
      'label': 'Star Label',
      'enable': false,
      'icon': Icon(Icons.grade),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? const Align(
            alignment: Alignment.center, child: CircularProgressIndicator())
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  // Obx(
                  //   () => controller.isLocationLocation.value
                  //       ? Align(alignment: Alignment.center, child: Text(""))
                  InkWell(
                    onTap: () async {
                      //_dataFromMapPin = await Get.toNamed(Routes.pin_map);
                      controller.offerPoolStartLocation =
                          await Get.to(PinMapScreen());
                      controller.offerPoolStartLocationController.text =
                          controller.offerPoolStartLocation!.completeAddress;
                    },
                    child: GetBuilder<HomeController>(
                      builder: (_) {
                        return TextFormField(
                          enabled: false,
                          controller:
                              controller.offerPoolStartLocationController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: "Start Location",
                            icon: Icon(
                              Iconsax.gps,
                              color: Color(0xff0FC874),
                            ),
                            filled: false,
                            focusedBorder: UnderlineInputBorder(),
                            enabledBorder: UnderlineInputBorder(),
                            errorBorder: UnderlineInputBorder(),
                            focusedErrorBorder: UnderlineInputBorder(),
                          ),
                        );
                      },
                    ),
                  ),
                  //   ),
                  TextFormField(
                      controller: controller.offerPoolDropLocationController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "Drop Location",
                        icon: Icon(
                          Iconsax.location,
                          color: Colors.red,
                        ),
                        filled: false,
                        focusedBorder: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(),
                        errorBorder: UnderlineInputBorder(),
                        focusedErrorBorder: UnderlineInputBorder(),
                      )),
                  SizedBox(
                    height: 15.h,
                  ),
                  DateTimePicker(
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'd MMM, yyyy',
                    initialValue: DateTime.now().toString(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    icon: Icon(Icons.event),
                    dateLabelText: 'Date',
                    timeLabelText: "Hour",
                    selectableDayPredicate: (date) {
                      // Disable weekend days to select from the calendar
                      if (date.weekday == 6 || date.weekday == 7) {
                        return false;
                      }
                      return true;
                    },
                    onChanged: (val) => print(val),
                    validator: (val) {
                      print(val);
                      return null;
                    },
                    onSaved: (val) => print(val),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  SelectFormField(
                    type: SelectFormFieldType.dropdown, // or can be dialog
                    //initialValue: '',
                    icon: Icon(Iconsax.car4),
                    labelText: 'Select Vehicle',
                    items: _items,
                    onChanged: (val) => print(val),
                    onSaved: (val) => print(val),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  _OfferPoolButton(),
                  SizedBox(
                    height: 15.h,
                  ),
                ]),
          ));
  }
}
