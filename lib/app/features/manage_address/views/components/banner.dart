part of manage_address;

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
                  "Manage Address",
                  style: TextStyle(fontSize: 25.r, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Pre Saved Address ",
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
                  "https://img.freepik.com/free-vector/isometric-taxi-car-order-service-app-yellow-cab_1441-3587.jpg?w=740",
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
