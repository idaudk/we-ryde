part of more_view;

class _UserStream extends GetView<MoreController> {
  _UserStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(controller.registrants.length.toString()),
    );
  }
}
