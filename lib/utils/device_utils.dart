import 'package:flutter/widgets.dart';

class DeviceUtils {
  static bool isTablet(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= 768;
  }

  static double getFontSize(BuildContext context) {
    return isTablet(context) ? 28.0 : 16.0;
  }

  static double getToolBarHeight(BuildContext context) {
    return isTablet(context) ? 120.0 : 60.0;
  }
  
  static double getBottomNavHeight(BuildContext context) {
    return isTablet(context) ? 100.0 : 60.0;
  }

  static double getHeaderSize(BuildContext context) {
    return isTablet(context) ? 28.0 : 20.0;
  }

  static double getSmallFontSize(BuildContext context) {
    return isTablet(context) ? 18.0 : 16.0;
  }

  static double getIconSize(BuildContext context) {
    return isTablet(context) ? 50.0 : 24.0;
  }

  static double getAvatarRadius(BuildContext context) {
    return isTablet(context) ? 70.0 : 40.0;
  }

  static double getAvatarRadiusAPI(BuildContext context) {
    return isTablet(context) ? 60.0 : 30.0;
  }
  static double getAvatarRadiusInfo(BuildContext context) {
    return isTablet(context) ? 150.0 : 70.0;
  }

  static double getHeightList(BuildContext context) {
    return isTablet(context) ? 130.0 : 70.0;
  }
}
