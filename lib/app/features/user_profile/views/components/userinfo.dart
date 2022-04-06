part of user_profile_screen;

class _Userinfo extends GetView<UserProfileController> {
  const _Userinfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SlideAnimation(
                begin: Offset(0, 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Profile",
                      style: TextStyle(
                          fontSize: 28.r, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Everything about you",
                      style: TextStyle(
                          fontSize: 12.r, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SlideAnimation(
                begin: Offset(0, 500),
                child: Stack(
                  overflow: Overflow.visible,
                  children: [
                    Container(
                      height: 90.h,
                      width: 90.w,
                      child: controller.imageIsLoading.value
                          ? const Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator())
                          : GetBuilder<UserProfileController>(
                              init: UserProfileController(),
                              builder: (controller) => controller
                                          .showLocalImage.value ==
                                      false
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        controller.user.value!.profileImage ==
                                                "-"
                                            ? "https://img.freepik.com/free-photo/handsome-young-man-with-new-stylish-haircut_176420-19637.jpg?t=st=1648123180~exp=1648123780~hmac=39b64ea5a82853c6c17321282f5712adf297e8e24a418df12a77661f503584d2&w=996"
                                            : controller
                                                .user.value!.profileImage,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.file(
                                        controller.pickedImage!,
                                        fit: BoxFit.cover,
                                      ))),
                    ),
                    Positioned(
                      top: 25.h,
                      left: -18.w,
                      child: InkWell(
                        onTap: () => Get.bottomSheet(
                          Container(
                            height: 130.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.w, vertical: 24.h),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Select Image:"),
                                SizedBox(height: 20.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton.icon(
                                        onPressed: () =>
                                              controller.pickImageFromCamera(),
                                        icon: const Icon(Iconsax.camera),
                                        label: const Text("Camera")),
                                    TextButton.icon(
                                        onPressed: () =>
                                            controller.pickImageFromDevice(),
                                        icon: const Icon(Iconsax.gallery),
                                        label: const Text("Gallery"))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          //backgroundColor: Colors.white
                        ),
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0xff0ec874),
                                borderRadius: BorderRadius.circular(40)),
                            width: 40.w,
                            height: 40.h,
                            child: Icon(
                              Iconsax.gallery_edit,
                              color: Colors.white,
                              size: 20,
                            )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
