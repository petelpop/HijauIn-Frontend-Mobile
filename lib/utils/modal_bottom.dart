import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/utils/modal_topbar.dart';

mixin ModalBottom {
  static Future show(
    BuildContext context, {
    required Widget view,
  }) async {
    return showModalBottomSheet(
      context: context,
      backgroundColor: whiteColor,
      enableDrag: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return view;
      },
    );
  }

  static Future showWithTopBar(
    BuildContext context, {
    required Widget view,
    required String title,
    bool enableDrag = true,
  }) async {
    return showModalBottomSheet(
      context: context,
      enableDrag: enableDrag,
      isDismissible: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
      ),
      builder: (context) {
        return ModalTopBar(
          title: title,
          view: view,
        );
      },
    );
  }
}
