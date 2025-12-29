import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import '/Services/api_service.dart';
import '/Services/consts.dart';
import '/Widgets/bottom_nav_bar.dart';
import '/Widgets/search_list.dart';
import 'package:unicons/unicons.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ScrollController _scrollController = ScrollController();
  bool isVisible = true;

  final searchController = TextEditingController();
  String query = "";

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(listen);
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    _scrollController.removeListener(listen);
    _scrollController.dispose();
  }

  /// Monitor scroll direction to show/hide the bottom navigation.
  void listen() {
    final direction = _scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
  }

  void show() {
    if (!isVisible) {
      (setState(
        () => isVisible = true,
      ));
    }
  }

  void hide() {
    if (isVisible) {
      (setState(
        () => isVisible = false,
      ));
    }
  }

  @override

  /// Student Note:
  /// The search screen presents a text input and displays results from `APIService.getSearchResult(query)`.
  /// Updates `query` as the user types (no debouncing implemented for this simple project).
  /// If the service fails, it returns an empty list to keep the UI from crashing.
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        GoRouter.of(context).go('/main');
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backgroundPrimary,
          bottomNavigationBar: AnimatedBuilder(
              animation: _scrollController,
              builder: ((context, child) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: isVisible ? 75 : 0,
                  child: const BottomNavBar(
                    currentIndex: 1,
                  ),
                );
              })),
          extendBody: true,
          body: Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Image.asset(
                'assets/backdrop.png',
                fit: BoxFit.fitWidth,
                width: size.width,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(8, 28, 8, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: accentT.withValues(alpha: 0.95),
                    ),
                    child: TextField(
                      onSubmitted: (value) async {
                        // Search is triggered by onChanged/setState rebuild
                      },
                      controller: searchController,
                      style: TextStyle(color: accentSecondary),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            UniconsLine.search,
                            color: Colors.white,
                          ),
                          prefixIconColor: Colors.white),
                      onChanged: (value) {
                        setState(() {
                          query = searchController.text;
                        });
                      },
                    ),
                  ),
                  SearchList(
                      APIService().getSearchResult(query), _scrollController)
                ],
              ),
            ],
          )),
    );
  }
}
