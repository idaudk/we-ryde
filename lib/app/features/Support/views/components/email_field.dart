part of support_screen;

class _EmailField extends GetView<SupportController> {
  const _EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: controller.email,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.trim() == "") return "";
        return null;
      },
      decoration:  InputDecoration(
        filled: false,
          focusedBorder: UnderlineInputBorder(),
          enabledBorder: UnderlineInputBorder(),
          border: UnderlineInputBorder(),
           labelText: "Add Contact info",
        errorBorder: UnderlineInputBorder(),
        focusedErrorBorder: UnderlineInputBorder(),

        labelStyle: TextStyle(fontWeight: FontWeight.w300,fontSize: 13.sp)
          ),
    );
  }
}
