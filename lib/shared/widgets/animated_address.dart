import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedAddressWidget extends StatefulWidget {
  final String address;
  final int index;

  const AnimatedAddressWidget({
    super.key,
    required this.address,
    required this.index,
  });

  @override
  AnimatedAddressWidgetState createState() => AnimatedAddressWidgetState();
}

class AnimatedAddressWidgetState extends State<AnimatedAddressWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  late Animation<Offset> _imageSlideAnimation;
  late Animation<double> _textFadeAnimation;
  bool _isAnimationStarted = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
          seconds: 2), // Set the duration of the entire animation
    );

    _imageSlideAnimation =
        Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _textFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(const Duration(seconds: 3), () {
      _startAnimation();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    if (!_isAnimationStarted) {
      _isAnimationStarted = true;
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Define the width animation here
    _widthAnimation = Tween<double>(begin: 0, end: screenWidth).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: _widthAnimation.value,
          height: 45,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15), // Blur effect
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(), // Placeholder to space out elements
                  // Text that fades in
                  Opacity(
                    opacity: _textFadeAnimation.value,
                    child: SizedBox(
                      width: widget.index == 0
                          ? _widthAnimation.value / 2
                          : _widthAnimation.value / 5,
                      child: Center(
                        child: Text(
                          widget.address,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w800,
                                    height: 1.2,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  // Image that slides from left to right
                  SlideTransition(
                    position: _imageSlideAnimation,
                    child: Container(
                      height: 45,
                      width: 45,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: Center(
                        child:
                            Image.asset('assets/images/angle-small-right.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
