import 'package:device_info_plus/device_info_plus.dart';

/// Provides data about user's device
abstract interface class IDeviceDataProvider {
  /// Returns user's device id.
  Future<String> getDeviceId();
}

/// User's device data provider.
class DeviceDataProvider implements IDeviceDataProvider {
  /// Cache for device id.
  String? deviceId;

  @override
  Future<String> getDeviceId() async {
    if (deviceId == null) {
      final deviceInfo = await DeviceInfoPlugin().deviceInfo;
      deviceId = deviceInfo.data['id'].toString();
    }
    return deviceId!;
  }
}
