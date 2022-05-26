part of home_view;

class FindPool extends GetView<HomeController> {
  FindPool({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
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
                    TextFormField(
                      enabled: false,
                      onTap: (() {
                        Get.snackbar("Hellow World", "just doing some testing");
                      }),
                      //controller: controller.startSearchFieldController,
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
                     
                    ),
                    //  ),
                    TextFormField(
                        controller: controller.endSearchFieldController,
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
                      height: 13.h,
                    ),
                    _FindPoolButton()
                  ]),
            ),
    );
  }
}
