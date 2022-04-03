import 'package:flutter/material.dart';
import 'package:krc/res/Images.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/header.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key key}) : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  AnimationController menuAnimController;
  List list = ["", "", ""];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double size = 135.0;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header("Image"),
            verticalSpace(20.0),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Wrap(
                children: [
                  InkWell(
                      onTap: () {
                        dialogz(context, Images.kPH6);
                      },
                      child: Image.asset(Images.kPH6, width: size, height: size, fit: BoxFit.fill)),
                  horizontalSpace(20.0),
                  InkWell(
                      onTap: () {
                        dialogz(context, Images.kPH8);
                      },
                      child: Image.asset(Images.kPH8, width: size, height: size, fit: BoxFit.fill)),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Wrap(
                children: [
                  Image.asset(Images.kPH8, width: size, height: size, fit: BoxFit.fill),
                  horizontalSpace(20.0),
                  Image.asset(Images.kPH6, width: size, height: size, fit: BoxFit.fill),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static Future<bool> dialogz(BuildContext context, String img) {
    return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              actions: <Widget>[
                Image.asset(img, fit: BoxFit.fill),
              ],
            );
          },
        ) ??
        false;
  }
}
