import 'package:flutter/cupertino.dart';
import 'package:krc/common_imports.dart';
import 'package:krc/ui/base/base_presenter.dart';
import 'package:krc/ui/profile/model/profile_detail_response.dart';
import 'package:krc/ui/profile/model/profile_upload_response.dart';
import 'package:krc/ui/profile/profile_view.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/Dialogs.dart';
import 'package:krc/utils/NetworkCheck.dart';
import 'package:krc/utils/Utility.dart';

class ProfilePresenter extends BasePresenter {
  ProfileView _profileView;

  ProfilePresenter(this._profileView) : super(_profileView);

  Future<void> uploadCustomerProfile(BuildContext context, String profile) async {
    //check network
    if (!await NetworkCheck.check()) return;

    if (profile.isEmpty) {
      _profileView.onError("Please select the profile pic to upload");
      return;
    }

    String? accountId = (await AuthUser().getCurrentUser())!.userCredentials!.accountId;

    var body = {"AccountID": accountId ?? "0013C00000edzftQAA", "BlobImage": profile};
    Dialogs.showLoader(context, "Uploading profile picture");
    apiController.post(EndPoints.POST_UPLOAD_PROFILE_PIC, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        ProfileUploadResponse profileUploadResponse = ProfileUploadResponse.fromJson(response.data);
        if (profileUploadResponse.returnCode!) {
          _profileView.onProfileUploaded();
        } else {
          _profileView.onError(profileUploadResponse.message);
        }
      })
      ..catchError((error) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(error, _profileView);
      });
  }

  Future<void> getProfileDetails(BuildContext context) async {
    //check network
    if (!await NetworkCheck.check()) return;

    String? accountId = (await AuthUser().getCurrentUser())!.userCredentials!.accountId;

    var body = {"AccountID": accountId};
    Dialogs.showLoader(context, "Getting profile details");
    apiController.post(EndPoints.GET_PROFILE_DETAIL, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        ProfileDetailResponse profileDetailResponse = ProfileDetailResponse.fromJson(response.data);
        if (profileDetailResponse.returnCode!) {
          _profileView.onProfileDetailsFetched(profileDetailResponse);
        } else {
          _profileView.onError(profileDetailResponse.message);
        }
      })
      ..catchError((error) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(error, _profileView);
      });
  }

  Future<void> getProfileDetailsNoLoader(BuildContext context) async {
    //check network
    if (!await NetworkCheck.check()) return;

    String? accountId = (await AuthUser().getCurrentUser())!.userCredentials!.accountId;

    var body = {"AccountID": accountId};
     apiController.post(EndPoints.GET_PROFILE_DETAIL, body: body, headers: await Utility.header())
      ..then((response) {
         ProfileDetailResponse profileDetailResponse = ProfileDetailResponse.fromJson(response.data);
        if (profileDetailResponse.returnCode!) {
          _profileView.onProfileDetailsFetched(profileDetailResponse);
        } else {
          _profileView.onError(profileDetailResponse.message);
        }
      })
      ..catchError((error) {
         ApiErrorParser.getResult(error, _profileView);
      });
  }
}

