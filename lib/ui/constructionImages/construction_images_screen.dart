import 'package:flutter/material.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/ui/constructionImages/construction_image_view.dart';
import 'package:krc/ui/constructionImages/model/construction_image_response.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/cached_image_widget.dart';
import 'package:krc/widgets/header.dart';

import 'construction_images_presenter.dart';

class ConstructionImagesScreen extends StatefulWidget {
  const ConstructionImagesScreen({Key key}) : super(key: key);

  @override
  _ConstructionImagesScreenState createState() => _ConstructionImagesScreenState();
}

class _ConstructionImagesScreenState extends State<ConstructionImagesScreen> implements ConstructionImageView {
  AnimationController menuAnimController;
  List<ResponseList> responseList = [];
  ConstructionImagePresenter _constructionImagePresenter;

  @override
  void initState() {
    super.initState();
    _constructionImagePresenter = ConstructionImagePresenter(this);
    _constructionImagePresenter.getConstructionImages(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header("Image"),
            verticalSpace(20.0),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Wrap(
                alignment: WrapAlignment.start,
                runSpacing: 20.0,
                spacing: 30.0,
                children: responseList.map<Widget>((e) => cardViewImage(e)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell cardViewImage(ResponseList link) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        dialogz(context, link?.imagelink);
      },
      child: Column(
        children: [
          CachedImageWidget(
            imageUrl: link?.imagelink,
            height: 135,
            width: 135,
            fit: BoxFit.fill,
          ),
          verticalSpace(20.0),
          Text("${link?.imageTitle}", style: textStyleWhite14px500w),
        ],
      ),
    );
  }

  static Future<bool> dialogz(BuildContext context, String img) {
    return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              actions: <Widget>[
                CachedImageWidget(
                  imageUrl: img,
                  height: 200,
                  radius: 0.0,
                  fit: BoxFit.fill,
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  void onConstructionImagesFetched(ConstructionImageResponse constructionImageResponse) {
    List<ResponseList> cstImageList = constructionImageResponse.responseList;
    responseList.addAll(cstImageList);
    setState(() {});
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }
}
