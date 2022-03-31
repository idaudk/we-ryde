part of user_profile_screen;

class _EmailField extends GetView<UserProfileController> {
  const _EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? Align(alignment: Alignment.topCenter, child: Text(""))
        : TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: controller.email,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.trim() == "") return "";
              return null;
            },
            decoration: InputDecoration(
                fillColor: Colors.white,
                focusColor: Colors.grey[300],
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0ec874)),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                labelText: "Email Address",
                labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.3))),
          ));
    ;
  }
}
