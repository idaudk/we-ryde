part of pin_map_view;

class _SearchBar extends GetView<PinMapController> {
  const _SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 7.h),
            //color: AppBasicTheme().secondaryColor,
            child: CupertinoTextField(
              prefix: Icon(Icons.search),
              //enabled: false,
              onTap: () {},
              controller: controller.searchTextField,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              placeholder: "Search",

              onChanged: (value) {
                controller.isLoading.value = true;
                print(value);
                controller.onChangeHandler(value);
              },
              suffix: IconButton(
                  onPressed: () {
                    controller.useCurrentLocationButtonHandler();
                  },
                  //padding: const EdgeInsets.all(10),
                  constraints: const BoxConstraints(),
                  icon: Icon(
                    Iconsax.gps,
                    color: AppBasicTheme().primaryColor,
                  )),
              decoration: const BoxDecoration(),
            ),
          ),

          Obx(() {
            return controller.isLoading.value == true
                ? const LinearProgressIndicator()
                : controller.showPredictions.value == true
                    ? _SearchListView()
                    : Container();
          })
          // Obx(
          //   () => controller.responses.isEmpty
          //       ? Container(
          //           child: Center(
          //             child: Text('is Empty'),
          //           ),
          //         )
          //       : _SearchListView(),
          // )
        ],
      ),
    );
  }
}
