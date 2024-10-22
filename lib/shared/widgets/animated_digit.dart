import 'package:flutter/material.dart';

class AnimatedDigit extends StatefulWidget {
  final int digit;
  final Duration duration;
  final TextStyle textStyle;

  const AnimatedDigit({
    required Key key,
    required this.digit,
    this.duration = const Duration(milliseconds: 1000),
    required this.textStyle,
  }) : super(key: key);

  @override
  AnimatedDigitState createState() => AnimatedDigitState();
}

class AnimatedDigitState extends State<AnimatedDigit>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late int displayDigit;

  @override
  void initState() {
    super.initState();

    displayDigit = widget.digit;

    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(seconds: 3), () {
      _animationController.forward();
    });
  }

  @override
  void didUpdateWidget(AnimatedDigit oldWidget) {
    super.didUpdateWidget(oldWidget);

    _animationController.reset();
    _animationController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.addListener(() {
      setState(() {
        displayDigit = int.parse(widget.digit.toString());
      });
    });

    final animatedValue = displayDigit * _animation.value;

    return Text(
      animatedValue.toInt().toString(),
      style: widget.textStyle,
    );
  }
}
