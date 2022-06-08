part of home_view;

// fastLinearToSlowEaseIn
class FindPool extends GetView<HomeController> {
  FindPool({Key? key}) : super(key: key);

  final findPoolFromKey = new GlobalKey<FormState>();

  final List<Map<String, dynamic>> _items = [
    {
      'value': '1',
      'label': '1 seat',
    },
    {
      'value': '2',
      'label': '2 seat',
    },
    {
      'value': '3',
      'label': '3 seat',
    },
    {
      'value': '4',
      'label': '4 seat',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const Align(
              alignment: Alignment.center, child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                //key: controller.findPoolformKey,
                child: ListView(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      InkWell(
                        onTap: () async {
                          controller.findPoolStartLocation =
                              await Get.to(() => PinMapScreen());
                          if (controller.findPoolStartLocation != null) {
                            controller.findPoolStartLocationController.text =
                                controller
                                    .findPoolStartLocation!.completeAddress;

                            //print('start position handler called');
                            controller.findPoolStartLocationMapHandler();
                          } else {
                            controller.findPoolStartLocationController.text =
                                '';
                            Get.snackbar('Alert!', 'Location was not selected!',
                                backgroundColor: Colors.white.withOpacity(0.3));
                          }
                        },
                        child: GetBuilder<HomeController>(
                          builder: (_) {
                            return TextFormField(
                              enabled: false,
                              controller:
                                  controller.findPoolStartLocationController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                return value!.isEmpty
                                    ? 'Location is Required.'
                                    : null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                      //  ),
                      InkWell(
                        onTap: () async {
                          if (controller.findPoolStartLocation == null) {
                            Get.snackbar('Select Origin Location first!',
                                'Origin location must be select in order to select destination location.');
                          } else {
                            controller.findPoolDropLocation =
                                await Get.to(() => PinMapScreen());
                            if (controller.findPoolDropLocation != null) {
                              controller.findPoolDropLocationController.text =
                                  controller
                                      .findPoolDropLocation!.completeAddress;

                              //print('start position handler called');
                              controller.findPoolDropLocationMapHandler();
                            } else {
                              controller.findPoolDropLocationController.text =
                                  '';
                              Get.snackbar(
                                  'Alert!', 'Location was not selected!',
                                  backgroundColor:
                                      Colors.white.withOpacity(0.3));
                            }
                          }
                        },
                        child: GetBuilder<HomeController>(
                          builder: (_) {
                            return TextFormField(
                                enabled: false,
                                controller:
                                    controller.findPoolDropLocationController,
                                keyboardType: TextInputType.text,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value!.isEmpty
                                      ? 'Location is Required.'
                                      : null;
                                },
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
                        height: 13.h,
                      ),
                      ExpansionWidget(
                          initiallyExpanded: false,
                          titleBuilder: (double animationValue, _,
                              bool isExpaned, toogleFunction) {
                            return InkWell(
                                onTap: () => toogleFunction(animated: true),
                                child: Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Advance search',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.r),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Transform.rotate(
                                        angle: math.pi * animationValue / 2,
                                        child: Icon(
                                          Iconsax.arrow_right_14,
                                          size: 15.r,
                                        ),
                                        alignment: Alignment.center,
                                      )
                                    ],
                                  ),
                                ));
                          },
                          content: Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(top: 13.h),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: InkWell(
                                          onTap: () async {
                                            controller.findPoolStartDate =
                                                (await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime.now()
                                                  .add(Duration(days: 15)),
                                            ));
                                            if (controller.findPoolStartDate !=
                                                null) {
                                              controller.findPoolDateController
                                                  .text = Jiffy(controller
                                                      .findPoolStartDate)
                                                  .yMMMMd;
                                            }
                                          },
                                          child: AbsorbPointer(
                                            child: TextFormField(
                                              maxLines: null,
                                              controller: controller
                                                  .findPoolDateController,
                                              decoration: const InputDecoration(
                                                  labelText: "Date",
                                                  icon: Icon(Iconsax.calendar)),
                                              textCapitalization:
                                                  TextCapitalization.words,
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
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: InkWell(
                                          onTap: () async {
                                            try {
                                              controller.findPoolStartTime =
                                                  (await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                              ))!;
                                              if (controller
                                                      .findPoolStartTime !=
                                                  null) {
                                                controller
                                                        .findPoolTimeController
                                                        .text =
                                                    controller
                                                        .findPoolStartTime!
                                                        .format(context);
                                              }
                                            } catch (ex) {
                                              print(ex);
                                            }
                                          },
                                          child: AbsorbPointer(
                                            child: TextFormField(
                                              maxLines: null,
                                              controller: controller
                                                  .findPoolTimeController,
                                              decoration: const InputDecoration(
                                                  labelText: "Time",
                                                  icon: Icon(Iconsax.clock)),
                                              textCapitalization:
                                                  TextCapitalization.words,
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
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 13.h,
                                  ),
                                  GetBuilder<HomeController>(
                                    builder: (_) {
                                      return SelectFormField(
                                        type: SelectFormFieldType
                                            .dropdown, // or can be dialog

                                        //controller: controller.selectVehicleController,
                                        icon: const Icon(Iconsax.car),
                                        labelText: 'No. of seats',
                                        items: _items,
                                        onChanged: (val) {
                                          //controller.selectedVehicleSetter(val);
                                        },
                                        onSaved: (val) => print(val),
                                      );
                                    },
                                  ),
                                ],
                              ))),
                      SizedBox(
                        height: 13.h,
                      ),
                      _FindPoolButton(),
                      SizedBox(
                        height: 13.h,
                      ),
                    ]),
              ),
            ),
    );
  }
}
