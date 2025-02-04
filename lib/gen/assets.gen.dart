/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsAnimationsGen {
  const $AssetsAnimationsGen();

  /// File path: assets/animations/login.riv
  String get login => 'assets/animations/login.riv';

  /// List of all assets
  List<String> get values => [login];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/breakfast.svg
  SvgGenImage get breakfast => const SvgGenImage('assets/icons/breakfast.svg');

  /// File path: assets/icons/dessert.svg
  SvgGenImage get dessert => const SvgGenImage('assets/icons/dessert.svg');

  /// File path: assets/icons/dinner.svg
  SvgGenImage get dinner => const SvgGenImage('assets/icons/dinner.svg');

  /// File path: assets/icons/lanch.svg
  SvgGenImage get lanch => const SvgGenImage('assets/icons/lanch.svg');

  /// File path: assets/icons/login_bg.svg
  SvgGenImage get loginBg => const SvgGenImage('assets/icons/login_bg.svg');

  /// File path: assets/icons/logo.svg
  SvgGenImage get logo => const SvgGenImage('assets/icons/logo.svg');

  /// File path: assets/icons/porridge.svg
  SvgGenImage get porridge => const SvgGenImage('assets/icons/porridge.svg');

  /// File path: assets/icons/snack.svg
  SvgGenImage get snack => const SvgGenImage('assets/icons/snack.svg');

  /// File path: assets/icons/snack_type.svg
  SvgGenImage get snackType => const SvgGenImage('assets/icons/snack_type.svg');

  /// File path: assets/icons/soup.svg
  SvgGenImage get soup => const SvgGenImage('assets/icons/soup.svg');

  /// File path: assets/icons/trip_bg.svg
  SvgGenImage get tripBg => const SvgGenImage('assets/icons/trip_bg.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        breakfast,
        dessert,
        dinner,
        lanch,
        loginBg,
        logo,
        porridge,
        snack,
        snackType,
        soup,
        tripBg
      ];
}

class $AssetsImageGen {
  const $AssetsImageGen();

  /// File path: assets/image/ic_launcher.png
  AssetGenImage get icLauncher =>
      const AssetGenImage('assets/image/ic_launcher.png');

  /// List of all assets
  List<AssetGenImage> get values => [icLauncher];
}

class Assets {
  Assets._();

  static const $AssetsAnimationsGen animations = $AssetsAnimationsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImageGen image = $AssetsImageGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
