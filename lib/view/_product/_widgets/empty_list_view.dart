import 'package:auto_size_text/auto_size_text.dart';
import 'package:pdv_windows/core/export/base_export.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class NoDataWidget extends StatelessWidget {
  final String message;

  const NoDataWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: context.padding.normal,
        child: AutoSizeText(
          message.tr(),
          maxLines: 2,
          textAlign: TextAlign.center,
          style: context.general.textTheme.titleLarge,
        ),
      ),
    );
  }
}
