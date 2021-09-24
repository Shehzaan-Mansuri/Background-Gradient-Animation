import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
void main() {
  runApp(MyCustomWidget());
}

class MyCustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(brightness: Brightness.dark),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnimatingBg(),
                ),
              );
            },
            child: Text('View Animated Background'),
          ),
        ),
      ),
    );
  }
}

class AnimatingBg extends StatefulWidget {
  @override
  _AnimatingBgState createState() => _AnimatingBgState();
}

class _AnimatingBgState extends State<AnimatingBg>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    _bc = AnimationController(
      duration: const Duration(seconds: 7),
      vsync: this,
    )..repeat();
    ba = CurvedAnimation(parent: _bc, curve: Curves.easeIn);
  }

  Animation<double> ba;

  AnimationController _bc;

  AlignmentTween aT =
  AlignmentTween(begin: Alignment.topRight, end: Alignment.topLeft);
  AlignmentTween aB =
  AlignmentTween(begin: Alignment.bottomRight, end: Alignment.bottomLeft);

  Animatable<Color> darkBackground = TweenSequence<Color>(
    [
      TweenSequenceItem(
        weight: .5,
        tween: ColorTween(
          begin: smalt.withOpacity(.8),
          end: oldRose.withOpacity(.8),
        ),
      ),
      TweenSequenceItem(
        weight: .5,
        tween: ColorTween(
          begin: oldRose.withOpacity(.8),
          end: smalt.withOpacity(.8),
        ),
      ),
    ],
  );

  Animatable<Color> normalBackground = TweenSequence<Color>(
    [
      TweenSequenceItem(
        weight: .5,
        tween: ColorTween(
          begin: smalt.withOpacity(.6),
          end: oldRose.withOpacity(.6),
        ),
      ),
      TweenSequenceItem(
        weight: .5,
        tween: ColorTween(
          begin: oldRose.withOpacity(.6),
          end: smalt.withOpacity(.6),
        ),
      ),
    ],
  );

  Animatable<Color> lightBackground = TweenSequence<Color>(
    [
      TweenSequenceItem(
        weight: .5,
        tween: ColorTween(
          begin: smalt.withOpacity(.4),
          end: oldRose.withOpacity(.4),
        ),
      ),
      TweenSequenceItem(
        weight: .5,
        tween: ColorTween(
          begin: oldRose.withOpacity(.4),
          end: smalt.withOpacity(.4),
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    double _h = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: ba,
      builder: (context, child) {
        return Scaffold(
          body: Container(
            width: _w,
            height: _h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: aT.evaluate(ba),
                end: aB.evaluate(ba),
                colors: [
                  darkBackground.evaluate(ba),
                  normalBackground.evaluate(ba),
                  lightBackground.evaluate(ba),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Color smalt = Color(0xff121856);
Color oldRose = Color(0xffD23756);