import 'package:flutter/cupertino.dart';

class PsyduckLoadingIndicator extends StatefulWidget
{
  @override
  _PsyduckLoadingIndicatorState createState() => _PsyduckLoadingIndicatorState();
}

class _PsyduckLoadingIndicatorState extends State<PsyduckLoadingIndicator>  with SingleTickerProviderStateMixin{
  Animation<double> animation;
  AnimationController _animationController;
  double opacityLevel = 1.0;

  @override
  void initState() {
    super.initState();
    _animationController =
    new AnimationController(vsync: this, duration: Duration(milliseconds: 750));
    _animationController.repeat(reverse: true);




  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return        FadeTransition(
        opacity: _animationController,
        child: Image.asset("assets/psyduck.png",width: 75,height: 75,));

  }
}