part of home_view;

class _FindPoolButton extends GetView<HomeController> {
  const _FindPoolButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ElevatedButton(
        onPressed: () {
          TripsController().goneToOtherPage.value = true;
         
          TripsController().dispose();
          controller.findPoolSearchButtonHandler();

          print('Value set to True ***********************************' +
              TripsController().goneToOtherPage.value.toString());
        },
        //controller.isLoading.value ? null : () => controller.register(),
        child: controller.isSearchButtonLoading.value
            ? const SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              )
            : const Text(
                "Find Pool",
                style: TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}
