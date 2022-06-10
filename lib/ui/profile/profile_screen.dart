import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Images.dart';
import 'package:krc/ui/profile/model/profile_detail_response.dart';
import 'package:krc/ui/profile/profile_presenter.dart';
import 'package:krc/ui/profile/profile_view.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> implements ProfileView {
  ProfilePresenter _profilePresenter;
  ProfileDetailResponse _profileDetailResponse;

  @override
  void initState() {
    super.initState();
    _profilePresenter = ProfilePresenter(this);
    _profilePresenter.getProfileDetails(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header('Profile'),
            verticalSpace(20.0),
            Column(
              children: [
                Row(
                  children: [
                    horizontalSpace(20.0),
                    InkWell(
                      onTap: () async {
                        String img = await Utility.pickImg(context);
                        _profilePresenter.uploadCustomerProfile(context, img);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80.0),
                        child: Container(
                          height: 80.0,
                          width: 80.0,
                          child: Image.memory(Utility.convertMemoryImage(_profileDetailResponse?.profilePic), fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    horizontalSpace(20.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(6.0),
                        Text('${_profileDetailResponse?.emailID ?? ""}', style: textStyleWhite16px700w),
                        Text('${_profileDetailResponse?.accountName ?? ""}', style: textStyleWhite14px500w),
                        Text('${_profileDetailResponse?.phone ?? ""}', style: textStyleWhite14px500w),
                        verticalSpace(20.0),
                      ],
                    ),
                  ],
                ),
                verticalSpace(50.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    horizontalSpace(50.0),
                    Image.asset(
                      Images.kIconMapExt,
                      height: 50.0,
                    ),
                    horizontalSpace(16.0),
                    Expanded(
                      child: RichText(
                        maxLines: 10,
                        text: TextSpan(
                          text: 'Permanent Address\n',
                          style: textStyleWhite16px700w,
                          children: [
                            TextSpan(
                              text: '${_profileDetailResponse?.address ?? ""}',
                              style: textStyleSubText12px500w,
                            ),
                          ],
                        ),
                      ),
                    ),
                    horizontalSpace(20.0),
                  ],
                ),
                /* verticalSpace(20.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    horizontalSpace(50.0),
                    Image.asset(
                      Images.kIconMapExt,
                      height: 50.0,
                    ),
                    horizontalSpace(16.0),
                    RichText(
                      maxLines: 10,
                      text: TextSpan(
                        text: 'Mailing Address\n',
                        style: textStyleWhite16px700w,
                        children: [
                          TextSpan(
                            text: 'Promount 12/23 block 233V East\n Mumbai sector 52',
                            style: textStyleSubText12px500w,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),*/
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  onError(String message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onProfileUploaded() {
    Utility.showSuccessToastB(context, "Profile uploaded");
    _profilePresenter.getProfileDetails(context);
  }

  @override
  void onProfileDetailsFetched(ProfileDetailResponse profileDetailResponse) {
    _profileDetailResponse = profileDetailResponse;
    setState(() {});
  }
}
