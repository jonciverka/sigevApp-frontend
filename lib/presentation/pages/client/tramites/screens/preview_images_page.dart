import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:sigev/config/theme/app_icons.dart';
import 'package:sigev/presentation/widgets/app_icon_buttons.dart';

class FotoViewer extends StatefulWidget {
  final int initialIndex;
  final List fotos;

  const FotoViewer({
    super.key,
    required this.initialIndex,
    required this.fotos,
  });

  @override
  _FotoViewerState createState() => _FotoViewerState();
}

class _FotoViewerState extends State<FotoViewer> {
  late PageController _pageController;
  late ValueNotifier<int> _currentIndex;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    _currentIndex = ValueNotifier(widget.initialIndex);

    // Escuchar cambios de página para actualizar la fecha
    _pageController.addListener(() {
      int newIndex = _pageController.page?.round() ?? widget.initialIndex;
      if (_currentIndex.value != newIndex) {
        _currentIndex.value = newIndex;
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              pageController: _pageController,
              pageSnapping: true,
              itemCount: widget.fotos.length,
              builder: (BuildContext context, int indexGallery) {
                return PhotoViewGalleryPageOptions(
                  minScale: PhotoViewComputedScale.contained * 1,
                  imageProvider: NetworkImage("${widget.fotos[indexGallery]}"),
                  initialScale: PhotoViewComputedScale.contained,
                  heroAttributes: PhotoViewHeroAttributes(
                    tag: widget.fotos[indexGallery] ?? '',
                  ),
                );
              },
            ),
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIconButton(
                    icon: AppIcons.arrowBack,
                    onPressed: () => Navigator.pop(context, false),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
