import 'package:flutter/material.dart';

import 'package:augmented_reality_plugin_wikitude/architect_widget.dart';
import 'package:augmented_reality_plugin_wikitude/startupConfiguration.dart';

class CamaraPage extends StatefulWidget {
  bool web;

  CamaraPage({@required this.web});

  @override
  _CamaraPageState createState() => _CamaraPageState();
}

class _CamaraPageState extends State<CamaraPage> with WidgetsBindingObserver {
  ArchitectWidget architectWidget;
  String wikitudeTrialLicenseKey =
      "ZhUb9Ox7dxQiu8HKS0DiBu/9of9bkNlXBXVdnRyo90sZJI9ihD0EwodRskR32+2Xk26LrEarVuRh+9ehZnMd37ZclAVTP4uk6/yYURIXFJngdVWczbap3AW9SP7ADwLQD34guNPe6prFhPOk5sJGuAOrzyWgAo/ATfvRGbjfwL9TYWx0ZWRfX/lB+5AtcdxhR9b2iqC7pmSPT/kUIGHXOXyejb2y8h95QWdoduXar2HsNswmoSJbpWCEgMj40EnUwgqz7srUc5K10IhjbuGaZOYAG1gPjWjs0yKepEzKjX/XzCYisn//rlXrIl9+bvmXERdEo2EQb8ZSY5ibKjzpkSnRZj8YwIa4I2/rI6zv8Jt6XSLpfZJM6H7rD1FJfEMvNv6b/UYqQCt9nAyn7pLU9TF0ij2NIDBrYpKwpemXl8QilxL7O+egW3qR/ZlaBlRBg+XwvFiBMaZ7YQlIPEo2se7wvFb41RtnI6LmcUWIv1el2S8XuAuS+yPm9SRMItOIrdnT87blLU21z1C7mLqkfr37GHS21onfkC4gUiX+fpxvXn/Oq4eRoUd7UmMUpaeF+iJl9PPTY9SVnX0bCbvW7/PhuVV0J+MAlx4f1jTPbUB+Gt4yurPCsais+a6dStFcfUR+KYrcKI+BDD2NHjJDFnQgZrX2oLKHoJ42Ekw3xVbyTErEGvMchhlkzQFRjSsHpmkI/Q5Emfv/3BOlGQljZn/1sVCd8DD5evqN2rKeemVkQK4ekYaxTZFc82BNuUk+3TsCtCIlWell6fvQorInaSTKRxV84xbdyDq7+5ywiTp7TJoWg1SsoKOWiKDGr8L0nYM47Xgg3umhRflX757E3DYUPwdcsibALcLHDtcVJp8=";
  bool loadFailed = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    architectWidget = new ArchitectWidget(
      onArchitectWidgetCreated: onArchitectWidgetCreated,
      licenseKey: wikitudeTrialLicenseKey,
      startupConfiguration: StartupConfiguration(
          cameraPosition: CameraPosition.BACK,
          cameraResolution: CameraResolution.AUTO),
      features: ["image_tracking"],
    );
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        if (this.architectWidget != null) {
          this.architectWidget.pause();
        }
        break;
      case AppLifecycleState.resumed:
        if (this.architectWidget != null) {
          this.architectWidget.resume();
        }
        break;

      default:
    }
  }

  @override
  void dispose() {
    if (this.architectWidget != null) {
      this.architectWidget.pause();
      this.architectWidget.destroy();
    }
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          decoration: BoxDecoration(color: Colors.black), child: architectWidget),
    );
  }

  Future<void> onArchitectWidgetCreated() async {
    this.architectWidget.load("assets/ar/index.html", onLoadSuccess, onLoadFailed);
    this.architectWidget.resume();
  }

  Future<void> onLoadSuccess() async {
    loadFailed = false;
  }

  Future<void> onLoadFailed(String error) async {
    loadFailed = true;
    this.architectWidget.showAlert("Failed to load Architect World", error);
  }
}
