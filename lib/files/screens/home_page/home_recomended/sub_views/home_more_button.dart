
/*
class HomeMoreButton extends StatefulWidget {
  final TuneInfo? info;
  final int index;
  final bool isWishlist;

  const HomeMoreButton(
      {super.key, this.info, required this.isWishlist, required this.index});

  @override
  State<StatefulWidget> createState() {
    return _HomeMoreButtonState();
  }
}

class _HomeMoreButtonState extends State<HomeMoreButton> {
  List<MenuModel> menuItem = [
    //MenuModel(shareStr.tr, imageName: shareSvg),
  ];
  late WishlistController wishCont;
  createMenuList() {
    if (widget.isWishlist) {
      wishCont = Get.find();
    }
    menuItem = [
      widget.isWishlist
          ? MenuModel(deleteStr.tr, imageName: deleteSvg)
          : MenuModel(wishlistStr.tr, imageName: wishlistSvg),
      //MenuModel(giftStr.tr, imageName: giftTuneSvg),
    ];
  }

  @override
  void initState() {
    createMenuList();
    super.initState();
  }

  final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      key: _key,
      height: 30,
      width: 30,
      color: Colors.white38,
      leftWidget: Image.asset(
        moreHorzontalImg,
        width: 20,
      ), //const Icon(Icons.more_horiz, color: white),
      onTap: () {
        printCustom(
            "StoreManager().isLoggedIn ====== ${StoreManager().isLoggedIn}");
        if (StoreManager().isLoggedIn) {
          showPopupMenu();
        } else {
          Get.dialog(
              CustomAlertView(title: featureIsAvailableForLoggedInStr.tr));
        }
      },
    );
  }

  showPopupMenu() {
    RecoController recoController = Get.find();
    showPositionedPopup(
      _key,
      menuItem,
      isSvg: true,
      width: 140,
      isLeft: true,
      onTap: (p0) async {
        if (p0.title == wishlistStr.tr) {
          recoController.wishlistTapped(widget.info);
        } else if (p0.title == giftStr.tr) {
          recoController.tellAFriendTapped();
        } else if (p0.title == shareStr.tr) {
          recoController.shareTapped();
        } else if (p0.title == deleteStr.tr) {
          wishCont.deleteFromWishlistAction(
              widget.info ?? TuneInfo(), widget.index);

          printCustom("Delete from wishlis make api call here");
        } else {
          printCustom("Default tapped");
        }
        printCustom("Item name is ${p0.title}");
      },
    );
  }
}
*/