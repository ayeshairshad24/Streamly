import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '/Models/search_result.dart';
import '/Widgets/search_card.dart';

class SearchList extends StatefulWidget {
  const SearchList(this.future, this.scrollController, {super.key});

  final Future<List<SearchResult>> future;
  final ScrollController scrollController;

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override

  /// I build a list of `SearchCard` widgets by awaiting the provided future.
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: widget.future,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: size.height * 0.8,
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 0),
              scrollDirection: Axis.vertical,
              controller: widget.scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (snapshot.data![index].mediaType == 'movie') {
                  var url = snapshot.data![index].posterPath;
                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      GoRouter.of(context)
                          .push('/movie/${snapshot.data![index].id}');
                    },
                    child: SearchCard(
                        snapshot.data![index].title.toString(),
                        url == null
                            ? const AssetImage("assets/LoadingImage.png")
                            : CachedNetworkImageProvider(
                                    "https://image.tmdb.org/t/p/original$url")
                                as ImageProvider,
                        snapshot.data![index].voteAverage.toString(),
                        'movie'),
                  );
                } else if (snapshot.data![index].mediaType == 'tv') {
                  var url = snapshot.data![index].posterPath;
                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      GoRouter.of(context)
                          .push('/tv/${snapshot.data![index].id}');
                    },
                    child: SearchCard(
                        snapshot.data![index].name.toString(),
                        url == null
                            ? const AssetImage("assets/LoadingImage.png")
                            : CachedNetworkImageProvider(
                                    "https://image.tmdb.org/t/p/original$url")
                                as ImageProvider,
                        snapshot.data![index].voteAverage.toString(),
                        'tv'),
                  );
                } else if (snapshot.data![index].mediaType == 'person') {
                  var url = snapshot.data![index].profilePath;
                  return SearchCard(
                      snapshot.data![index].name.toString(),
                      url == null
                          ? const AssetImage("assets/LoadingImage.png")
                          : CachedNetworkImageProvider(
                                  "https://image.tmdb.org/t/p/original$url")
                              as ImageProvider,
                      snapshot.data![index].popularity.toString(),
                      'person');
                } else {
                  return const SearchCard("Loading",
                       AssetImage("assets/LoadingImage.png"), "0", 'N/A');
                }
              },
            ),
          );
        } else {
          return const SearchCard("Loading",
               AssetImage("assets/LoadingImage.png"), "0", 'N/A');
        }
      },
    );
  }
}
