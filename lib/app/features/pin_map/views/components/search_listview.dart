part of pin_map_view;

class _SearchListView extends GetView<PinMapController> {
  const _SearchListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PinMapController>(builder: (_) {
      return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.responses.length,
          itemBuilder: (_, index) {
            return Column(
              children: [
                ListTile(
                  onTap: () {
                    // String text =
                    //     controller.responses[index]['location'].toString();
                    controller.showPredictions.value = false;
                    controller.mapController!
                        .animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                        //bearing: 0,
                        target: controller.responses[index]['location'],
                        zoom: 14.0,
                      ),
                    ));
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  leading: const SizedBox(
                    height: double.infinity,
                    child: CircleAvatar(child: Icon(Iconsax.map)),
                  ),
                  title: Text(controller.responses[index]['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(controller.responses[index]['address'],
                      overflow: TextOverflow.ellipsis),
                ),
                const Divider(),
              ],
            );
          });
    });
  }
}
