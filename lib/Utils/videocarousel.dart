import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';

class VideoCarouselWidget extends StatefulWidget {
  final double left;
  final double top;
  final double width;
  final double height;

  const VideoCarouselWidget({
    Key? key,
    required this.left,
    required this.top,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  _VideoCarouselWidgetState createState() => _VideoCarouselWidgetState();
}

class _VideoCarouselWidgetState extends State<VideoCarouselWidget> {
  late VideoPlayerController _controller1;
  late VideoPlayerController _controller2;
  late List<VideoPlayerController> _controllers;

  @override
  void initState() {
    super.initState();

    _controller1 = VideoPlayerController.asset('assets/videos/Original.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller1.setLooping(true);
        _controller1.setVolume(0.0); // Muted audio
        _controller1.play();
      });

    _controller2 = VideoPlayerController.asset('assets/videos/Transparente.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller2.setLooping(true);
        _controller2.setVolume(0.0); // Muted audio
        _controller2.play();
      });

    _controllers = [_controller1, _controller2];
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  CarouselSlider buildCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 1,
        aspectRatio: 16 / 9,
        autoPlayInterval: Duration(seconds: 5),
        onPageChanged: (index, reason) {
          _controllers.forEach((controller) {
            controller.pause();
          });
          _controllers[index].play();
        },
      ),
      items: _controllers.map((controller) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15), // Rounded corners
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15), // Rounded corners
                child: controller.value.isInitialized
                    ? AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                )
                    : Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.left,
      top: widget.top,
      width: widget.width,
      height: widget.height,
      child: buildCarousel(),
    );
  }
}