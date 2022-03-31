part of user_profile_screen;

class _SavedButton extends GetView<UserProfileController> {
  const _SavedButton({Key? key}) : super(key: key);

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
            : Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}
