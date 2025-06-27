import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/resources/color_manger.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: BackButton(
            color: AppColorManger.white,
          ),
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            alignment: Alignment.center,
            child: InteractiveViewer(
                maxScale: 5,
                child: Hero(
                  tag: imageUrl,
                  child: CachedNetworkImage(
                    width: double.infinity,
                    height: double.infinity,
                    imageUrl: imageUrl,
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
