part of more_view;

class _Userinfo extends GetView<MoreController> {
  const _Userinfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => controller.isLoading.value
                ? Align(
                    alignment: Alignment.topCenter,
                    child: CircularProgressIndicator())
                : SlideAnimation(
                    begin: Offset(-250, 0),
                    child: Column(
                      children: [
                        Text(
                          controller.user.value?.name ?? "-",
                          style: TextStyle(
                              fontSize: 28.r, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          controller.user.value?.phoneNumber ?? "-",
                          style: TextStyle(
                              fontSize: 12.r, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
          ),
          SlideAnimation(
            child: Container(
              height: 90.h,
              width: 90.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "https://img.freepik.com/free-photo/handsome-young-man-with-new-stylish-haircut_176420-19637.jpg?t=st=1648123180~exp=1648123780~hmac=39b64ea5a82853c6c17321282f5712adf297e8e24a418df12a77661f503584d2&w=996",
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
