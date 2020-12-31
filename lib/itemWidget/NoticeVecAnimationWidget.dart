import 'package:flutter/cupertino.dart';

class NoticeVecAnimationWidget extends StatefulWidget {
  final Duration duration;
  final List<String> messages;

  const NoticeVecAnimationWidget(
      {Key key,
      this.duration = const Duration(milliseconds: 5000),
      this.messages})
      : super(key: key);

  @override
  NoticeVecAnimationState createState() {
    return NoticeVecAnimationState();
  }
}

class NoticeVecAnimationState extends State<NoticeVecAnimationWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;

  int _nextMassage = 0;

  // 透明度
  Animation<double> _opacityAni1, _opacityAni2;

  //位移
  Animation<Offset> _positionAni1, _positionAni2;

  @override
  Widget build(BuildContext context) {
    startVerticalAni();
    //正向开启动画
    return SlideTransition(
      position: _positionAni2,
      child: FadeTransition(
        opacity: _opacityAni2,
        child: SlideTransition(
          position: _positionAni1,
          child: FadeTransition(
            opacity: _opacityAni1,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: Text(
                    widget.messages[_nextMassage],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Color(0xffee565656)),
                  ),
                ),
              ],
            ),

            /*Text(
              widget.messages[_nextMassage],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
           //   style: GlobalConstant.middleText,
            ),*/
          ),
        ),
      ),
    );
  }

  void startVerticalAni() {
    if (_controller != null) {
      return;
    }

    _controller = AnimationController(duration: widget.duration, vsync: this);

    _opacityAni1 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.0, 0.1, curve: Curves.linear)));

    _opacityAni2 = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _controller, curve: Interval(0.9, 1.0, curve: Curves.linear)),
    );

    _positionAni1 = Tween<Offset>(
      begin: const Offset(0.0, 0.2),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
        parent: _controller, curve: Interval(0.0, 0.1, curve: Curves.linear)));

    _positionAni2 = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, -0.3),
    ).animate(
      CurvedAnimation(
          parent: _controller, curve: Interval(0.9, 1.0, curve: Curves.linear)),
    );

    _controller
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _nextMassage++;
            if (_nextMassage >= widget.messages.length) {
              _nextMassage = 0;
            }
          });
          _controller.reset();
          _controller.forward();
        }
        if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller = null;
    super.dispose();
  }
}
