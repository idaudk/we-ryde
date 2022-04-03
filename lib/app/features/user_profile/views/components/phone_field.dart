part of user_profile_screen;

class _PhoneField extends GetView<UserProfileController> {
  const _PhoneField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? Align(alignment: Alignment.topCenter, child: Text(""))
        // : Card(
        //     child: ListTile(
        //       title: Text(controller.user.value?.name ?? "-"),
        //       subtitle: Text(controller.user.value?.phoneNumber ?? "-"),
        //     ),
        //   ),
        : TextFormField(
            readOnly: true,
            keyboardType: TextInputType.phone,
            controller: controller.phoneNumber,
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
                labelText: "Phone Number",
                labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.3))),
          ));
  }
}
