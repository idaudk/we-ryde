part of about_us_screen;

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
                  "We Ryde",
                  style: TextStyle(fontSize: 28.r, fontWeight: FontWeight.bold),
                ),
                Text(
                  "About Us",
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
                  "https://img.freepik.com/free-vector/confident-people-collection-design_23-2148407807.jpg?t=st=1648799251~exp=1648799851~hmac=94916a9385ba08eae8d583ae65d1f7d702301cb085b86a2115d0c93a76daa338&w=740",
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
