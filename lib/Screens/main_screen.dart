import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '/Models/popular_movies.dart';
import '/Models/tv_show.dart';
import '/Services/api_service.dart';
import '/Services/consts.dart';
import '/Widgets/bottom_nav_bar.dart';
import '/Widgets/carousel_card.dart';
import '/Widgets/custom_lists.dart';
import '/Widgets/loading_screen.dart';
import '/Widgets/section_text.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ScrollController _scrollController = ScrollController();
  bool isVisible = true;

  late List<Results> popularMovie;
  late List<Results> topRatedMovie;
  late List<Results> nowPLayingMovie;
  late List<TvShow> popularShows;
  late List<TvShow> topRatedShows;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
    _scrollController = ScrollController();
    _scrollController.addListener(listen);
  }

  @override
  void dispose() {
    _scrollController.removeListener(listen);
    _scrollController.dispose();
    super.dispose();
  }

  /// I observe scrolling to show or hide the bottom navigation for a cleaner UI.
  void listen() {
    final direction = _scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
  }

  /// I reveal UI elements like the bottom nav when the user scrolls up.
  void show() {
    if (!isVisible) {
      (setState(
        () => isVisible = true,
      ));
    }
  }

  /// I hide UI elements when the user scrolls down to focus on content.
  void hide() {
    if (isVisible) {
      (setState(
        () => isVisible = false,
      ));
    }
  }

  /// I load lists used on the home screen (popular, top rated, on-air, etc.).
  Future<void> fetchData() async {
    topRatedShows = await APIService().getTopRatedShow();
    popularMovie = await APIService().getPopularMovie();
    topRatedMovie = await APIService().getTopRatedMovie();
    popularShows = await APIService().getRecommendedTvShows("1396");
    nowPLayingMovie = await APIService().getNowPLayingMovie();
    setState(() {
      isLoading = false;
    });
  }

  @override

  /// I compose the main landing screen with carousels and horizontal lists.
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: AnimatedBuilder(
          animation: _scrollController,
          builder: ((context, child) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              curve: Curves.fastLinearToSlowEaseIn,
              height: isVisible ? 75 : 0,
              child: const BottomNavBar(
                currentIndex: 0,
              ),
            );
          })),
      extendBody: true,
      body: isLoading
          ? const LoadingScreen()
          : Container(
              height: size.height,
              width: size.width,
              color: backgroundPrimary,
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                shrinkWrap: true,
                children: [
                  CustomCarouselSlider(topRatedShows),
                  SectionText("Popular", "Movies"),
                  CustomListMovie(popularMovie),
                  SectionText("TOP Rated", "Movies"),
                  CustomListMovie(topRatedMovie),
                  SectionText("Popular", "Shows"),
                  CustomListTV(popularShows),
                  SectionText("NoW PLAying", "Movies"),
                  CustomListMovie(nowPLayingMovie),
                ],
              ),
            ),
    );
  }
}
