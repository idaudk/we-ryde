part of support_screen;

class _LoginButton extends GetView<SupportController> {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => ElevatedButton(
        onPressed: controller.isLoading.value ? null : () => {},
        child: controller.isLoading.value
            ? SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(),
        )
            : Text("SUBMIT",style: TextStyle(color: Colors.white,),),
      ),
    );
  }
}
