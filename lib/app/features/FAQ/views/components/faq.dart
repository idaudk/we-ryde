part of faq_screen;

class Item {
  final String id;
  final String expandedValue;
  final String headerValue;
  Item(
    this.id,
    this.expandedValue,
    this.headerValue,
  );

  factory Item.fromJson(dynamic json) {
    return Item(
        "${json['id']}", "${json['expandedValue']}", "${json['headerValue']}");
  }
}

var mylist = [
  {
    "id": "1",
    "headerValue": "How To Create a Ride?",
    "expandedValue":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  },
  {
    "id": "2",
    "headerValue": "How To Offer a Ride?",
    "expandedValue":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  },
  {
    "id": "3",
    "headerValue": "How To Add Money in Wallet?",
    "expandedValue":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  },
  {
    "id": "4",
    "headerValue": "How To Send Money To bank? ",
    "expandedValue":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  },
  {
    "id": "5",
    "headerValue": "How To Add My Vehicles? ",
    "expandedValue":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  },
  {
    "id": "6",
    "headerValue": "How To Change  Language?  ",
    "expandedValue":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  },
  {
    "id": "7",
    "headerValue": "Can I login through social account ?  ",
    "expandedValue":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  },
  {
    "id": "8",
    "headerValue": "How to logout my account ?  ",
    "expandedValue":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  },
];

getFeedbackList() {
  return mylist.map((json) => Item.fromJson(json)).toList();
}

class ExpansionItems extends StatefulWidget {
  const ExpansionItems({Key? key}) : super(key: key);

  @override
  State<ExpansionItems> createState() => _ExpansionItemsState();
}

class _ExpansionItemsState extends State<ExpansionItems> {
  final List<Item> _data = getFeedbackList();
  @override
  Widget build(BuildContext context) {
    print(_data);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList.radio(
      animationDuration: Duration(milliseconds: 200),
      initialOpenPanelValue: 1,
      elevation: 0,
      children: _data.map<ExpansionPanelRadio>(
        (Item item) {
          return ExpansionPanelRadio(
            canTapOnHeader: true,
            backgroundColor: Colors.white,
            value: item.id,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                selectedTileColor: Colors.red,
                title: Text(item.headerValue),
              );
            },
            body: ListTile(
              title: Text(
                item.expandedValue,
                style: TextStyle(),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
