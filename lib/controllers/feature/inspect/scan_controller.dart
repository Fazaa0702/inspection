import 'dart:async';
import 'dart:convert';

import 'package:flutter_datawedge/flutter_datawedge.dart';
import 'package:flutter_datawedge/models/scan_result.dart';
import 'package:get/get.dart';

class ScanController extends GetxController {
  late StreamSubscription<ScanResult> onScanResultListener;
  List<ScanResult> scanResults = [];
  late FlutterDataWedge fdw;

  final scannerMode = false.obs;

  @override
  void onInit() async {
    super.onInit();
    initScanner();
    changeScannerMode();
    print('Init Scanner: $initScanner');
    print(scannerMode);
  }

  @override
  void onClose() {
    fdw.scannerControl(false);
    scannerMode.value = !scannerMode.value;
    print(scannerMode);
  }

  changeScannerMode() {
    fdw.scannerControl(!scannerMode.value);
    scannerMode.value = !scannerMode.value;
  }

  Future<void> initScanner() async {
    fdw = FlutterDataWedge(profileName: 'HSEConnect');
    onScanResultListener = fdw.onScanResult.listen((result) async {
      print('Data: ${jsonEncode(result.data)}');
    });
    await fdw.initialize();
  }
}
