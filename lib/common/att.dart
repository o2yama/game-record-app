import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

class ATT {
  ATT._();
  static final ATT instance = ATT._();

  Future<bool> requestPermission() async {
    var result = false;

    if (Platform.isIOS) {
      final trackingStatus =
          await AppTrackingTransparency.trackingAuthorizationStatus;
      if (trackingStatus == TrackingStatus.notDetermined) {
        final status =
            await AppTrackingTransparency.requestTrackingAuthorization();
        if (status == TrackingStatus.authorized) {
          result = true;
        }
      } else if (trackingStatus == TrackingStatus.authorized) {
        result = true;
      } else if (trackingStatus == TrackingStatus.notSupported) {
        result = true;
      }
    } else {
      result = true;
    }
    return result;
  }
}
