part of my_vehciles_screen;

class _SaveButton extends GetView<MyVehiclesController> {
  const _SaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ElevatedButton(
        onPressed: controller.isButtonLoading.value
            ? null
            : () => controller.saveButtonHandler(),
        child: controller.isButtonLoading.value
            ? const SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              )
            : const Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}
