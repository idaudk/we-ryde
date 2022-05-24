part of pin_map_view;

class _SearchBar extends GetView<PinMapController> {
  const _SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.loadPredictions();
      },
      child: Container(
        alignment: Alignment.center,
        height: 55.h,
        width: MediaQuery.of(context).size.width - 40.w,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.h),
        decoration: BoxDecoration(
            color: AppBasicTheme().secondaryColor,
            borderRadius: BorderRadius.circular(12)),
        child: TextFormField(
          enabled: false,
          onTap: () {},
          //controller: controller.startSearchFieldController,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            hintText: "Search location",
            icon: Icon(
              Iconsax.search_normal_1,
              color: Color(0xff0FC874),
            ),
            filled: false,
            focusedBorder: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(),
            errorBorder: UnderlineInputBorder(),
            focusedErrorBorder: UnderlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
