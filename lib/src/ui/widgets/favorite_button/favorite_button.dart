import 'package:flutter/material.dart';

import 'bubbles_painter.dart';
import 'button_model.dart';
import 'button_utils.dart';
import 'circle_painter.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    Key? key,
    this.size = 30.0,
    this.favoriteBuilder,
    double? bubblesSize,
    double? circleSize,
    this.isFavorite = false,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.bubblesColor = const BubblesColor(
      dotPrimaryColor: Color(0xFFFFC107),
      dotSecondaryColor: Color(0xFFFF9800),
      dotThirdColor: Color(0xFFFF5722),
      dotLastColor: Color(0xFFF44336),
    ),
    this.circleColor =
        const CircleColor(start: Color(0xFFFF5722), end: Color(0xFFFFC107)),
    this.onTap,
    this.padding,
  })  : bubblesSize = bubblesSize ?? size * 2.0,
        circleSize = circleSize ?? size * 0.8,
        super(key: key);

  final double size;
  final Duration animationDuration;
  final double bubblesSize;
  final BubblesColor bubblesColor;
  final double circleSize;
  final CircleColor circleColor;
  final FavoriteButtonTapCallback? onTap;
  final bool? isFavorite;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final FavoriteWidgetBuilder? favoriteBuilder;
  final EdgeInsetsGeometry? padding;

  @override
  State<StatefulWidget> createState() => FavoriteButtonState();
}

class FavoriteButtonState extends State<FavoriteButton>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  late Animation<double> _outerCircleAnimation;
  late Animation<double> _innerCircleAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _bubblesAnimation;

  bool? _isFavorite = false;
  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;

    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _initAnimation();
  }

  @override
  void didUpdateWidget(FavoriteButton oldWidget) {
    _isFavorite = widget.isFavorite;

    if (_controller?.duration != widget.animationDuration) {
      _controller?.dispose();
      _controller =
          AnimationController(duration: widget.animationDuration, vsync: this);
      _initAnimation();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => onTap(context),
      child: Padding(
        padding: widget.padding ?? EdgeInsets.zero,
        child: AnimatedBuilder(
          animation: _controller!,
          builder: (BuildContext c, Widget? w) {
            final Widget favoriteWidget =
                widget.favoriteBuilder?.call(_isFavorite ?? true) ??
                    defaultWidgetBuilder(_isFavorite ?? true, widget.size);
            return Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  top: (widget.size - widget.bubblesSize) / 2.0,
                  left: (widget.size - widget.bubblesSize) / 2.0,
                  child: CustomPaint(
                    size: Size(widget.bubblesSize, widget.bubblesSize),
                    painter: BubblesPainter(
                      currentProgress: _bubblesAnimation.value,
                      color1: widget.bubblesColor.dotPrimaryColor,
                      color2: widget.bubblesColor.dotSecondaryColor,
                      color3: widget.bubblesColor.dotThirdColorReal,
                      color4: widget.bubblesColor.dotLastColorReal,
                    ),
                  ),
                ),
                Positioned(
                  top: (widget.size - widget.circleSize) / 2.0,
                  left: (widget.size - widget.circleSize) / 2.0,
                  child: CustomPaint(
                    size: Size(widget.circleSize, widget.circleSize),
                    painter: CirclePainter(
                      innerCircleRadiusProgress: _innerCircleAnimation.value,
                      outerCircleRadiusProgress: _outerCircleAnimation.value,
                      circleColor: widget.circleColor,
                    ),
                  ),
                ),
                Container(
                  width: widget.size,
                  height: widget.size,
                  alignment: Alignment.center,
                  child: Transform.scale(
                    scale: ((_isFavorite ?? true) && _controller!.isAnimating)
                        ? _scaleAnimation.value
                        : 1.0,
                    child: SizedBox(
                      child: favoriteWidget,
                      height: widget.size,
                      width: widget.size,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void onTap(BuildContext context) {
    if (_controller!.isAnimating) {
      return;
    }
    if (widget.onTap != null) {
      widget.onTap!(context, _isFavorite ?? true).then((bool isFavorite) {
        _handleIsFavoriteChanged(isFavorite);
      });
    } else {
      _handleIsFavoriteChanged(!(_isFavorite ?? true));
    }
  }

  void _handleIsFavoriteChanged(bool? isFavorite) {
    if (_isFavorite == null) {
      if (mounted) {
        setState(() {
          _controller!.reset();
          _controller!.forward();
        });
      }
      return;
    }

    if (isFavorite != null && isFavorite != _isFavorite) {
      _isFavorite = isFavorite;
      if (mounted) {
        setState(() {
          if (_isFavorite!) {
            _controller!.reset();
            _controller!.forward();
          }
        });
      }
    }
  }

  void _initAnimation() {
    _outerCircleAnimation = Tween<double>(
      begin: 0.1,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: const Interval(
          0.0,
          0.3,
          curve: Curves.ease,
        ),
      ),
    );
    _innerCircleAnimation = Tween<double>(
      begin: 0.2,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: const Interval(
          0.2,
          0.5,
          curve: Curves.ease,
        ),
      ),
    );
    final Animation<double> animate = Tween<double>(
      begin: 0.2,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: const Interval(
          0.35,
          0.7,
          curve: OvershootCurve(),
        ),
      ),
    );
    _scaleAnimation = animate;
    _bubblesAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: const Interval(
          0.1,
          1.0,
          curve: Curves.decelerate,
        ),
      ),
    );
  }
}
