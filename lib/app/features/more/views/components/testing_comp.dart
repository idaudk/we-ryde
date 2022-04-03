part of more_view;

class _TestingComp extends GetView<MoreController> {
  _TestingComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(controller.auth.currentUser!.uid)
            .snapshots(), //returns a Stream<DocumentSnapshot>
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userDocument = snapshot.data;
          return new Text(userDocument!["name"]);
        });
  }
}
