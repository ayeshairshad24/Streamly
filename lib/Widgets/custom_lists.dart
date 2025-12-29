import 'package:flutter/material.dart';
import '/Models/popular_movies.dart';
import '/Models/tv_show.dart';
import '/Widgets/movie_card.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// I render a horizontally scrolling list of movie thumbnails, keeping state for smooth scrolling.
class CustomListMovie extends StatefulWidget {
  const CustomListMovie(this.data, {super.key});
  final List<Results> data;

  @override
  State<CustomListMovie> createState() => _CustomListMovieState();
}

class _CustomListMovieState extends State<CustomListMovie>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
        height: 200,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: widget.data.length > 20 ? 20 : widget.data.length,
          cacheExtent: 9999,
          itemBuilder: ((context, index) {
            var url = widget.data[index].posterPath.toString();
            return KeyedSubtree(
                key: UniqueKey(),
                child: MovieCard(
                    widget.data[index].title.toString(),
                    CachedNetworkImageProvider(
                        "https://image.tmdb.org/t/p/w500$url"),
                    widget.data[index].id.toString(),
                    "movie"));
          }),
        ));
  }
}

/// I render a horizontally scrolling list of TV shows, reusing the movie card layout.
class CustomListTV extends StatefulWidget {
  const CustomListTV(this.data, {super.key});
  final List<TvShow> data;

  @override
  State<CustomListTV> createState() => _CustomListTVState();
}

class _CustomListTVState extends State<CustomListTV>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
        height: 200,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: widget.data.length > 20 ? 20 : widget.data.length,
          itemBuilder: ((context, index) {
            var url = widget.data[index].posterPath.toString();
            return KeyedSubtree(
                key: UniqueKey(),
                child: MovieCard(
                    widget.data[index].name.toString(),
                    NetworkImage("https://image.tmdb.org/t/p/w500$url"),
                    widget.data[index].id.toString(),
                    "tv"));
          }),
        ));
  }
}
