import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:popover/popover.dart';

showPopover1(BuildContext context) {
  showPopover(
      context: context,
      onPop: () => print('Popover was popped!'),
      direction: PopoverDirection.bottom,
      width: 200,
      height: 400,
      arrowHeight: 15,
      arrowWidth: 30,
      bodyBuilder: (context) {
        return Container(
          color: red,
          height: 110,
          width: 200,
        );
      });
}

class MoreButton extends StatefulWidget {
  final Widget icon;

  const MoreButton({super.key, required this.icon});
  @override
  _MoreButtonState createState() => _MoreButtonState();
}

class _MoreButtonState extends State<MoreButton> {
//class MoreButton extends StatelessWidget {

  late List<ChatModel> messages;
  late List<ItemModel> menuItems;
  CustomPopupMenuController _controller = CustomPopupMenuController();

  @override
  void initState() {
    menuItems = [
      ItemModel('Delete', Icons.delete),
      ItemModel('group_add', Icons.group_add),
      ItemModel('Buy', Icons.card_travel),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      position: PreferredPosition.bottom,
      child: widget.icon,
      // Container(
      //   child: Icon(Icons.add_circle_outline, color: Colors.red),
      //   padding: EdgeInsets.all(20),
      // ),
      menuBuilder: () => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: Colors.white,
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: menuItems
                  .map(
                    (item) => GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        print("onTap");
                        _controller.hideMenu();
                      },
                      child: Container(
                        height: 30,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              item.icon,
                              size: 15,
                              color: Colors.black,
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                //padding: EdgeInsets.symmetric(vertical: ),
                                child: Text(
                                  item.title,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
      pressType: PressType.singleClick,
      verticalMargin: -100,
      arrowColor: Colors.white,

      controller: _controller,
    );
    // LayoutBuilder(
    //   builder: (context, constraint) {
    //     return
    //   },
    // );
    PopupMenuButton(
      offset: const Offset(0, 50),
      initialValue: 0,
      child: widget.icon,
      itemBuilder: (context) {
        return List.generate(3, (index) {
          return PopupMenuItem(
            value: index,
            child: Text(' no $index'),
          );
        });
      },
    );
  }
}

class ChatModel {
  String content;
  bool isMe;

  ChatModel(this.content, {this.isMe = false});
}

class ItemModel {
  String title;
  IconData icon;

  ItemModel(this.title, this.icon);
}
