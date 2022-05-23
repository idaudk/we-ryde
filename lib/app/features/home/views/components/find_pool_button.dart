part of home_view;

class _FindPoolButton extends GetView<HomeController> {
  const _FindPoolButton({Key? key}) : super(key: key);

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
                "Find Pool",
                style: TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}
