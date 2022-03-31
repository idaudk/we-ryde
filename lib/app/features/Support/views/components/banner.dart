part of support_screen;

class _Banner extends StatelessWidget{
  const _Banner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SlideAnimation(
            begin: Offset(-250, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Support",
                  style: TextStyle(fontSize: 28.r, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Connect with us",
                  style: TextStyle(fontSize: 12.r, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          SlideAnimation(
            child:  Container(
              height: 90.h,
              width: 90.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
    "https://img.freepik.com/free-vector/customer-giving-quality-feedback_74855-5482.jpg?t=st=1648546622~exp=1648547222~hmac=107daa5bb1d2be9873c4496cfec422e18e6d5e7f11c850d5b3ab045e732c287f&w=740"     ,
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
