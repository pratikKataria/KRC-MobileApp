import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krc/generated/assets.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Screens.dart';
import 'package:krc/ui/profile/model/profile_detail_response.dart';
import 'package:krc/ui/profile/profile_presenter.dart';
import 'package:krc/ui/profile/profile_view.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/utils/extension.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> implements ProfileView {
  late ProfilePresenter _profilePresenter;
  ProfileDetailResponse? _profileDetailResponse;

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
            Container(
              color: AppColors.colorPrimary,
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                children: [
                  horizontalSpace(20.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(80.0),
                    child: Container(
                      height: 90.0,
                      width: 90.0,
                      child: Image.memory(Utility.convertMemoryImage(_profileDetailResponse?.profilePic), fit: BoxFit.fill),
                    ),
                  ),
                  // Image.asset(Assets.imagesIcPlaceholderEditProfile, height: 90.0),
                  horizontalSpace(10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(_profileDetailResponse?.accountName ?? "", style: textStyleWhite16px500w),
                        Text("${_profileDetailResponse?.emailID}".notNull, style: textStyleWhite14px500w),
                        Text("${_profileDetailResponse?.phone}".notNull, style: textStyleWhite14px500w),
                      ],
                    ),
                  ),

                  Icon(Icons.edit, color: Colors.white).onClick(() async {
                    String img = await Utility.pickImg(context);
                    _profilePresenter.uploadCustomerProfile(context, img);
                  }),
                  horizontalSpace(20.0),
                ],
              ),
            ),
            verticalSpace(20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        Assets.imagesIcApplicants,
                        height: 24.0,
                      ),
                      horizontalSpace(20.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Co-Applicants", style: textStyle14px500w),
                            verticalSpace(8.0),
                            Wrap(
                              runSpacing: 10.0,
                              spacing: 10.0,
                              children: [
                                if (_profileDetailResponse?.coApplicant1 != null)
                                  Container(
                                    color: AppColors.profileDetailApplicantBg,
                                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                    child: Text("${_profileDetailResponse?.coApplicant1}", style: textStyle12px500w),
                                  ),
                                if (_profileDetailResponse?.coApplicant2 != null)
                                  Container(
                                    color: AppColors.profileDetailApplicantBg,
                                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                    child: Text("${_profileDetailResponse?.coApplicant2}", style: textStyle12px500w),
                                  ),
                                if (_profileDetailResponse?.coApplicant3 != null)
                                  Container(
                                    color: AppColors.profileDetailApplicantBg,
                                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                    child: Text("${_profileDetailResponse?.coApplicant3}", style: textStyle12px500w),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(20.0),
                  line(),
                  verticalSpace(20.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.location_on, color: AppColors.colorPrimary),
                      horizontalSpace(20.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Permanent Address", style: textStyle14px500w),
                            verticalSpace(8.0),
                            Text(
                              "${_profileDetailResponse?.permanentAddress}".notNull,
                              style: textStyleSubText14px500w,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(20.0),
                  line(),
                  verticalSpace(20.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.location_on, color: AppColors.colorPrimary),
                      horizontalSpace(20.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Mailing Address", style: textStyle14px500w),
                            verticalSpace(8.0),
                            Text(
                              "${_profileDetailResponse?.mailingAddress}",
                              style: textStyleSubText14px500w,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(20.0),
                  line(),
                  verticalSpace(10.0),
                  Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app, color: AppColors.colorPrimary),
                      horizontalSpace(20.0),
                      Text("Logout", style: textStyle14px500w),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.colorPrimary,
                        size: 14.0,
                      ),
                    ],
                  ).onClick(() async {
                    Navigator.pop(context);
                    await AuthUser.getInstance().logout();
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushNamed(context, Screens.kLoginScreen);
                  }),
                  verticalSpace(10.0),
                  line(),
                  verticalSpace(20.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  onError(String? message) {
    Utility.showErrorToastB(context, message);
  }

  @override
  void onProfileUploaded() {
    Utility.showSuccessToastB(context, "Profile uploaded");
    _profilePresenter.getProfileDetailsNoLoader(context);
  }

  @override
  void onProfileDetailsFetched(ProfileDetailResponse profileDetailResponse) {
    _profileDetailResponse = profileDetailResponse;
    setState(() {});
  }
}

/*




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


*/
