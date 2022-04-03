part of user_profile_screen;

class _SavedButton extends GetView<UserProfileController> {
  const _SavedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ElevatedButton(
        onPressed: controller.isButtonLoading.value
            ? null
            : () => controller.updateUser(),
        child: controller.isButtonLoading.value
            ? SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              )
            : Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}
