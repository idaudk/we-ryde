part of support_screen;

class _FeedBack extends GetView<SupportController> {
  const _FeedBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: controller.feedback,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.trim() == "") return "";
        return null;
      },
      decoration:InputDecoration(
          filled: false,
          focusedBorder: UnderlineInputBorder(),
          enabledBorder: UnderlineInputBorder(),
          errorBorder: UnderlineInputBorder(),
          focusedErrorBorder: UnderlineInputBorder(),
          labelText: "Add Your Issue/FeedBack",
        labelStyle: TextStyle(fontWeight: FontWeight.w300,fontSize: 13.sp)

      )
    );
  }
}
