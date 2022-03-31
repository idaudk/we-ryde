part of faq_screen;

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
                  "FAQs",
                  style: TextStyle(fontSize: 28.r, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Get your answer",
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
                  "https://img.freepik.com/free-vector/faq-concept-flat-background_23-2148146562.jpg?t=st=1648721042~exp=1648721642~hmac=46c36b43dde1aa29edc2c20d718f3e050e52331af8a26178de5b7bfab2a1397c&w=740",
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
