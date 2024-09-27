import 'package:flutter/material.dart';
import 'package:pdv_windows/view/_product/_constants/image_path.dart';
import 'package:kartal/kartal.dart';
import 'package:pdv_windows/core/base/view/base_widget.dart';
import 'package:pdv_windows/view/splash/viewmodel/splash_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SplashViewModel>(
      viewModel: SplashViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: buildScaffoldBody,
    );
  }

  Widget buildScaffoldBody(BuildContext context, SplashViewModel viewModel) {
    return Scaffold(
      backgroundColor: context.colorScheme.onSurface,
      body: SafeArea(
        child: Center(
          child: TweenAnimationBuilder(
            duration: context.durationNormal,
            tween: Tween<double>(begin: 0.0, end: 1.0),
            curve: Curves.decelerate,
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: child,
              );
            },
            child: Image.asset(
              ImagePaths.instance.logo,
              height: 2000,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Text(
        DeviceUtility.instance.packageInfo?.version ?? "",
        textAlign: TextAlign.center,
        style: context.textTheme.bodyMedium?.copyWith(
          color: Colors.black,
        ),
      ),
    );
  }
}
