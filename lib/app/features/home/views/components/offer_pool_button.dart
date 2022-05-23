part of home_view;

class _OfferPoolButton extends GetView<HomeController> {
  const _OfferPoolButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ElevatedButton(
        onPressed: () {},
        //controller.isLoading.value ? null : () => controller.register(),
        child: controller.isLoading.value
            ? SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              )
            : Text(
                "Offer Pool",
                style: TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}
