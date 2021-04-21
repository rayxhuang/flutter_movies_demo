import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/domain/movie/movie.dart';

class MovieDisplayWidget extends StatelessWidget {
  final MovieEntity movie;
  final AnimationController animationController;
  final int offsetMultiplier;

  MovieDisplayWidget({@required this.movie, @required this.animationController, @required this.offsetMultiplier});

  @override
  Widget build(BuildContext context) {
    final Animation<double> _animationOpacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInQuart,
        )
    );

    final Animation<Offset> _animationOffset = Tween<Offset>(begin: Offset(0, offsetMultiplier + 1.toDouble()), end: const Offset(0, 0)).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        )
    );

    return FadeTransition(
      opacity: _animationOpacity,
      child: SlideTransition(
        position: _animationOffset,
        child: Container(
          child: Stack(
            fit: StackFit.expand,
            children: [
              getPosterImage(),
              Positioned(
                left: 12,
                right: 12,
                bottom: 20,
                child: Text(
                  '${this.movie.title}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Image getPosterImage() {
    try {
      return Image.network(
        this.movie.imageURL,
        fit: BoxFit.fill,
        errorBuilder: (context, dynamic, error) =>
            Image.asset(
              'assets/images/error-image.png',
              fit: BoxFit.fill,
            ),
      );
    } catch (e) {
      return Image.asset(
        'assets/images/error-image.png',
        fit: BoxFit.fill,
      );
    }
  }
}