part of home_view;

class _OfferPoolButton extends GetView<HomeController> {
  const _OfferPoolButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ElevatedButton(
        onPressed: () {
          controller.isbuttonLoading.value = true;
          controller.postNewRide();
        },
        //controller.isLoading.value ? null : () => controller.register(),
        child: controller.isbuttonLoading.value
            ? const SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              )
            : const Text(
                "Offer Pool",
                style: TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}
