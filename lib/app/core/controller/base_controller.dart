import 'package:cga_app/app/core/ui/helpers/messager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

abstract class BaseController extends GetxController {
  BaseController();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  void showLoading() {
    if (!_isLoading.value) {
      _isLoading.value = true;
    }
  }

  void hideLoading() {
    if (_isLoading.value) {
      _isLoading.value = false;
    }
  }

  final _message = Rxn<MessagerType>();

  void showMessage(MessagerType message) {
    _message.value = message;
  }

  @override
  void onReady() {
    _bindLoadingListener();
    _bindMessageListener();
    super.onReady();
    onControllerReady();
  }

  void onControllerReady() async{}

  void _bindLoadingListener() {
    ever<bool>(_isLoading, (loading) {
      if (loading) {
        if (!(Get.isDialogOpen ?? false)) {
          Get.dialog(
            const PopScope(
              canPop: false,
              child: Center(child: CircularProgressIndicator()),
            ),
            barrierDismissible: false,
          );
        }
      } else {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
      }
    });
  }

  void _bindMessageListener() {
    ever<MessagerType?>(_message, (msg) {
      if (msg != null) {
        toastification.show(
          type: msg.type,
          style: ToastificationStyle.flatColored,
          autoCloseDuration: const Duration(seconds: 5),
          title: Text(msg.title),
          description: RichText(text: TextSpan(text: msg.message)),
          alignment: Alignment.topRight,
          direction: TextDirection.ltr,
          animationDuration: const Duration(milliseconds: 300),
          icon: const Icon(Icons.check),
          showIcon: true, 
          showProgressBar: true,
          closeOnClick: true,
          pauseOnHover: true
        );
        _message.value = null;
      }
    });
  }
}
