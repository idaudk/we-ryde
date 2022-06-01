part of home_view;

class OfferPool extends GetView<HomeController> {
  OfferPool({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'Loading....',
      'label': 'Loading....',
      // 'icon': Icon(Iconsax.car),
      // 'textStyle': TextStyle(color: Colors.green),
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
                  InkWell(
                    onTap: () async {
                      controller.offerPoolStartLocation =
                          await Get.to(() => PinMapScreen());
                      if (controller.offerPoolStartLocation != null) {
                        controller.offerPoolStartLocationController.text =
                            controller.offerPoolStartLocation!.completeAddress;

                        //print('start position handler called');
                        controller.startLocationMapHandler();
                      } else {
                        controller.offerPoolStartLocationController.text = '';
                        Get.snackbar('Alert!', 'Location was not selected!',
                            backgroundColor: Colors.white.withOpacity(0.3));
                      }
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
                  InkWell(
                    onTap: () async {
                      if (controller.offerPoolStartLocation == null) {
                        Get.snackbar('Select Origin Location first!',
                            'Origin location must be select in order to select destination location.');
                      } else {
                        controller.offerPoolDropLocation =
                            await Get.to(() => PinMapScreen());
                        if (controller.offerPoolDropLocation != null) {
                          controller.offerPoolDropLocationController.text =
                              controller.offerPoolDropLocation!.completeAddress;

                          //print('start position handler called');
                          controller.dropLocationMapHandler();
                        } else {
                          controller.offerPoolDropLocationController.text = '';
                          Get.snackbar('Alert!', 'Location was not selected!',
                              backgroundColor: Colors.white.withOpacity(0.3));
                        }
                      }
                    },
                    child: GetBuilder<HomeController>(
                      builder: (_) {
                        return TextFormField(
                            enabled: false,
                            controller:
                                controller.offerPoolDropLocationController,
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
                            ));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: InkWell(
                          onTap: () async {
                            controller.startDate = (await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(Duration(days: 15)),
                            ));
                            if (controller.startDate != null) {
                              controller.offerPoolDateController.text =
                                  Jiffy(controller.startDate).yMMMMd;
                            }
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              maxLines: null,
                              controller: controller.offerPoolDateController,
                              decoration: const InputDecoration(
                                  labelText: "Date",
                                  icon: Icon(Iconsax.calendar)),
                              textCapitalization: TextCapitalization.words,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter the date of your departure';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () async {
                            try {
                              controller.startTime = (await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ))!;
                              if (controller.startTime != null) {
                                controller.offerPoolTimeController.text =
                                    controller.startTime!.format(context);
                              }
                            } catch (ex) {
                              print(ex);
                            }
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              maxLines: null,
                              controller: controller.offerPoolTimeController,
                              decoration: const InputDecoration(
                                  labelText: "Time", icon: Icon(Iconsax.clock)),
                              textCapitalization: TextCapitalization.words,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter the time of your departure';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  GetBuilder<HomeController>(
                    builder: (_) {
                      return SelectFormField(
                        type: SelectFormFieldType.dropdown, // or can be dialog
                        //initialValue: '',
                        controller: controller.selectVehicleController,
                        icon: const Icon(Iconsax.car4),
                        labelText: 'Select Vehicle',
                        items: controller.selectVehicleValues,
                        onChanged: (val) {
                          controller.selectedVehicleSetter(val);
                        },
                        onSaved: (val) => print(val),
                      );
                    },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextFormField(
                      enabled: true,
                      controller: controller.offerPoolMessageController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "Message",
                        icon: Icon(
                          Iconsax.note_1,
                        ),
                      )),
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
