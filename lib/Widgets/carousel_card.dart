import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '/Models/tv_show.dart';
import 'landing_card.dart';

/// I build the main landing carousel used to feature TV shows with navigation on tap.
// ignore: must_be_immutable
class CustomCarouselSlider extends StatelessWidget {
  CustomCarouselSlider(this.data, {super.key});
  List<TvShow> data;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width,
        height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
        child: PageView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          pageSnapping: true,
          itemCount: 20,
          itemBuilder: ((context, index) {
            var url = data[index].backdropPath.toString();
            return GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                GoRouter.of(context).push('/tv/${data[index].id}');
              },
              child: LandingCard(
                  CachedNetworkImageProvider(
                      "https://image.tmdb.org/t/p/original$url"),
                  data[index].name.toString()),
            );
          }),
        ));
  }
}
