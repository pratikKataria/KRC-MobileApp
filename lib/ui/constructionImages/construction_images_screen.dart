import 'package:flutter/material.dart';
import 'package:krc/controller/current_booking_detail_controller.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/ui/bottomNavigation/home/model/booking_list_response.dart';
import 'package:krc/ui/constructionImages/construction_image_view.dart';
import 'package:krc/ui/constructionImages/model/construction_image_response.dart' as Cti;
import 'package:krc/user/CurrentUser.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/utils/extension.dart';
import 'package:krc/widgets/cached_image_widget.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:krc/user/login_response.dart' as login;
import '../../user/AuthUser.dart';
import 'construction_images_presenter.dart';

class ConstructionImagesScreen extends StatefulWidget {
  const ConstructionImagesScreen({Key? key}) : super(key: key);

  @override
  _ConstructionImagesScreenState createState() => _ConstructionImagesScreenState();
}

class _ConstructionImagesScreenState extends State<ConstructionImagesScreen> with TickerProviderStateMixin implements ConstructionImageView {
  late TabController _tabController = TabController(length: 0, vsync: this);

  AnimationController? menuAnimController;
  List<Cti.ResponseList> listOfImages = [];
  late ConstructionImagePresenter _constructionImagePresenter;
  List<login.BookingList> listOfBooking = [];
  Map<String, List<Cti.ResponseList>> mapOfOpportunityIdAndReceipts = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      CurrentUser? currentUser = await AuthUser.getInstance().getCurrentUser();
      _constructionImagePresenter = ConstructionImagePresenter(this);
      listOfBooking.addAll((currentUser?.userCredentials?.bookingList?.toList() ?? []));
      _tabController = TabController(length: listOfBooking.length, vsync: this);
      if (listOfBooking.isNotEmpty) _constructionImagePresenter.getConstructionImages(context, listOfBooking.first.bookingId ?? '');
      mapOfOpportunityIdAndReceipts[listOfBooking.first.bookingId ?? ''] = listOfImages;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(10.0),
              if (_tabController.length > 1) buildTabs(),
              verticalSpace(10),
              line(width: Utility.screenWidth(context)),
              verticalSpace(10),

              // verticalSpace(40.0),
              // Text("${currentBookingDetailController.value?.project}", style: textStyle14px600w),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Text("Unit Number: ${currentBookingDetailController.value?.unit}", style: textStyle14px500w),
              //     horizontalSpace(10.0),
              //     Container(height: 6.0, width: 6.0, color: AppColors.colorPrimary),
              //     horizontalSpace(10.0),
              //     Expanded(child: Text("Tower: ${currentBookingDetailController.value?.tower}", style: textStyle14px500w)),
              //   ],
              // ),
              // verticalSpace(20.0),
              verticalSpace(20.0),
              Container(
                child: Wrap(
                  alignment: WrapAlignment.start,
                  runSpacing: 5.0,
                  spacing: 5.0,
                  children: listOfImages.map<Widget>((e) => cardViewImage(e)).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TabBar buildTabs() {
    return TabBar(
      controller: _tabController,
      dividerHeight: 0,
      indicatorColor: AppColors.colorPrimary,
      unselectedLabelStyle: textStyle14px300w,
      unselectedLabelColor: AppColors.textColorBlack,
      labelStyle: textStyle14px600w,
      labelColor: AppColors.textColor,
      isScrollable: _tabController.length > 2,
      onTap: (int index) async {
        String bookingId = listOfBooking[index].bookingId ?? "";
        print("booking id of selected tab is ${bookingId}");
        _constructionImagePresenter.getConstructionImages(context, bookingId);
        mapOfOpportunityIdAndReceipts[bookingId] = listOfImages;
        setState(() {});
        listOfImages.clear();
      },
      tabs: [...listOfBooking.map((e) => Tab(text: "${e.unit}"))],
    );
  }

  InkWell cardViewImage(Cti.ResponseList response) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        dialog(context, response);
      },
      child: Column(
        children: [
          if (response.imagelink == null || response.imagelink == '')Container(margin: EdgeInsets.only(top: 250.0), child: Center(child: Text("No Images Found", style: textStyle14px500w))),
          if (response.imagelink != null || response.imagelink != '')
            CachedImageWidget(
              imageUrl: response.imagelink,
              height: 80,
              width: 100,
              radius: 8.0,
              fit: BoxFit.fill,
            ),
          // verticalSpace(20.0),
          // Text("${link?.imageTitle}", style: textStyleWhite14px500w),
        ],
      ),
    );
  }

  Future<bool> dialog(BuildContext context, Cti.ResponseList? data) {
    return showDialog(
          context: context,
          builder: (BuildContext context) {
            int indexOfCurrentImage = listOfImages.indexOf(data!);

            return StatefulBuilder(builder: (context, alertDialogState) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                insetPadding: EdgeInsets.zero,
                actions: <Widget>[
                  Container(
                    width: Utility.screenWidth(context),
                    height: Utility.screenWidth(context),
                    child: PinchZoom(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(8.0),
                          child: CachedImageWidget(
                            imageUrl: listOfImages[indexOfCurrentImage].imagelink,
                            radius: 0.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      resetDuration: const Duration(milliseconds: 100),
                      maxScale: 2.5,
                      onZoomStart: () {
                        print('Start zooming');
                      },
                      onZoomEnd: () {
                        print('Stop zooming');
                      },
                    ),
                  ),
                  verticalSpace(20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 35.0,
                        height: 35.0,
                        // padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                        child: Icon(Icons.arrow_back_ios, size: 14),
                      ).onClick(() {
                        if (indexOfCurrentImage > 0) {
                          indexOfCurrentImage--;
                        }
                        alertDialogState(() {});
                      }),
                      horizontalSpace(20.0),
                      Text("${indexOfCurrentImage + 1}/${listOfImages.length}", style: textStyleWhite14px600w),
                      horizontalSpace(20.0),
                      Container(
                        width: 35.0,
                        height: 35.0,
                        // padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                        child: Icon(Icons.arrow_forward_ios, size: 14),
                      ).onClick(() {
                        if (indexOfCurrentImage < listOfImages.length - 1) {
                          indexOfCurrentImage++;
                        }
                        alertDialogState(() {});
                      }),
                    ],
                  )
                ],
              );
            });
          },
        ).then((value) => value as bool) ??
        false as Future<bool>;
  }

  @override
  void onConstructionImagesFetched(Cti.ConstructionImageResponse constructionImageResponse) {
    List<Cti.ResponseList> cstImageList = constructionImageResponse.responseList!;
    listOfImages.addAll(cstImageList);
    setState(() {});
  }

  @override
  onError(String? message) {
    Utility.showErrorToastB(context, message);
  }
}
