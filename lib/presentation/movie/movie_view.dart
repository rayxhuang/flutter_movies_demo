import 'package:flutter/material.dart';
import 'package:flutter_app_demo/application/movie/movie_bloc.dart';
import 'package:flutter_app_demo/application/core/network/network_bloc.dart';
import 'package:flutter_app_demo/domain/movie/movie.dart';
import 'package:flutter_app_demo/infrastructure/movie/movie_repo.dart';
import 'package:flutter_app_demo/presentation/presentation_const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviePage extends StatefulWidget{
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> with SingleTickerProviderStateMixin{
  AnimationController _movieAnimationController;

  @override
  void initState() {
    super.initState();
    _movieAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _movieAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkBloc, NetworkState>(
      listenWhen: (previous, current) => previous != current,
      listener: (BuildContext context, state) {
        if (state is NetworkLostConnectionState) {
          ScaffoldMessenger.of(context).showSnackBar(kLostConnectionSnackBar);
        } else if (state is NetworkConnectedState) {
          ScaffoldMessenger.of(context).showSnackBar(kRegainedConnectionSnackBar);
        }
      },
      child: BlocProvider(
        create: (context) => MovieBloc(
          movieRepo: MovieRepoImpl(),
          networkBloc: BlocProvider.of<NetworkBloc>(context),
        )..add(MovieGetMoviesEvent()),
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (BuildContext context, state) {
            if (state is MovieLoadedSuccessfulState) {
              _movieAnimationController.forward();
              return Container(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                    childAspectRatio: 0.618,
                  ),
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    return MovieDisplayWidget(
                      movie: state.movies[index],
                      animationController: _movieAnimationController,
                      offsetMultiplier: index ~/ 2,
                    );
                  }
                ),
              );
            } else if (state is MovieLoadingState) {
              return MovieLoadingWidget();
            } else if (state is MovieErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(kLostConnectionSnackBar);
              return Container();
            } else {
              return const Center(child: CircularProgressIndicator(),);
            }
          },
        )
      ),
    );
  }
}

class MovieLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 10,),
            const Text('Connected to internet, loading...'),
          ],
        ),
      )
    );
  }
}

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

