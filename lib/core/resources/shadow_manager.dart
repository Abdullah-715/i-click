import 'package:flutter/material.dart';

class ShadowManager {
  static Shadow dropShadow = Shadow(
    blurRadius: 40,
    color: const Color(0xff26292B).withOpacity(.07),
    offset: const Offset(0, 4),
  );

  static Shadow innerShadow = Shadow(
    blurRadius: 40,
    color: const Color(0xff26292B).withOpacity(.07),
    offset: const Offset(0, 4),
  );

  static Shadow layerBlur = const Shadow(
    blurRadius: 40,
  );

  static Shadow backgroundBlur = const Shadow(
    blurRadius: 40,
  );
}
