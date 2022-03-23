part of registration_view;

class _PhoneNumberField extends GetView<RegistrationController> {
  const _PhoneNumberField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.phoneNumber,
      keyboardType: TextInputType.phone,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.trim() == "") return "";
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Phone Number",
          prefixText: "+92 ",
          prefixIcon: Icon(
            Icons.phone,
            color: Colors.grey,
          ),
          hintText: "xxx xxxxxxx"),
    );
  }
}
