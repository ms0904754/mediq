import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../Model/Medicine.dart';
import '../Screens/AddMedicineScreen.dart';
import '../Screens/HomeScreen.dart';
import '../Screens/ReportScreen.dart';

class AppController extends GetxController {
  var count = 1.obs;
  var tpd = "One Time".obs;
  var currScreen = "home".obs;
  var isValidUser = false.obs;
  var isConnected = true.obs;
  var isDialogShowing = false.obs;
  var isEmailValid = true.obs;
  var isPasswordValid = true.obs;
  RxList<Medicine> medicines = <Medicine>[].obs;

  void checkInternet() {
    checkConnectivity();
    // Listen to connectivity changes
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      handleConnectivityChange(result);
    });
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    handleConnectivityChange(connectivityResult);
  }

  void handleConnectivityChange(ConnectivityResult result) {
    isConnected.value = result != ConnectivityResult.none;
    if (!isConnected.value) {
      if (!isDialogShowing.value) {
        showNoInternetDialog();
      }
    } else {
      if (isDialogShowing.value) {
        Get.back(); // Close dialog
        isDialogShowing.value = false;
      }
    }
  }

  void showNoInternetDialog() {
    isDialogShowing.value = true;
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Your Device is not connected',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/empty_box.jpg',
                  height: 150,
                ),
                const SizedBox(height: 20),
                Text(
                  'Connect your device with',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue[400],
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: const Icon(
                          Icons.bluetooth,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 50,
                      color: Colors.white,
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue[400],
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: const Icon(
                          Icons.wifi,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void addMedicine(Medicine medicine) {
    medicines.add(medicine);
    medicines.refresh();
  }

}
