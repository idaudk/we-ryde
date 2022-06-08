part of search_pool;

class _AppBar extends StatelessWidget {
  String? endSubLocality;
  _AppBar({Key? key, this.endSubLocality}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideAnimation(
      begin: const Offset(-300, 0),
      child: ScaleAnimation(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.arrow_back)),
              SizedBox(width: 16.h),
              endSubLocality == null
                  ? Text(
                      'Poolers on 25 Jun, 10 : 30 am',
                      style: TextStyle(
                          fontSize: 16.r, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      'Poolers going to ' + endSubLocality!,
                      style: TextStyle(
                          fontSize: 16.r, fontWeight: FontWeight.bold),
                    ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
