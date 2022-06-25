part of trips_screen;

class _AcceptButton extends GetView<TripsController> {
  RequestModel requestModel;
  RideModel rideModel;
  _AcceptButton({Key? key, required this.requestModel, required this.rideModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ElevatedButton(
        onPressed: controller.isButtonLoading.value
            ? null
            : () => {
                  controller.AcceptButtonHandler(
                      rideModel: rideModel, requestModel: requestModel)
                },
        child: controller.isButtonLoading.value
            ? SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              )
            : Text(
                "Accept",
                style: TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}
