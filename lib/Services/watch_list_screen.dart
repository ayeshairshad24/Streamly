import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/Services/api_service.dart';
import '/Services/consts.dart';

class WatchListScreen extends StatefulWidget {
  final List watchList;
  final String status;

  const WatchListScreen(
      {required this.watchList, required this.status, super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.status, style: const TextStyle(color: Colors.white)),
        backgroundColor: backgroundPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      backgroundColor: backgroundPrimary,
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.watchList.length,
        itemBuilder: (BuildContext context, int index) {
          final item = widget.watchList[index];
          // Adding a key here ensures the list items don't glitch when recycled
          return FutureBuilder(
            key: ValueKey(item["Id"]),
            future: watchListItem(item["Id"], item["mediaType"], context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data as Widget;
              } else if (snapshot.hasError) {
                return const Center(
                    child: Icon(Icons.error, color: Colors.red));
              } else {
                // Return a sized box to prevent layout jumping while loading
                return const SizedBox(height: 150);
              }
            }, // Close builder
          ); // Close FutureBuilder
        }, // Close itemBuilder
      ), // Close ListView.builder
    );
  }
}

Future<Widget> watchListItem(
    String id, String mediaType, BuildContext context) async {
  dynamic details;

  try {
    if (mediaType == "movie") {
      details = await APIService().getMovieDetail(id);
      return GestureDetector(
        onTap: () => GoRouter.of(context).push('/movie/$id'),
        child: _buildItemRow(
          title: details.title ?? "Unknown",
          date: "Release: ${details.releaseDate ?? 'N/A'}",
          rating: details.voteAverage?.toStringAsFixed(1) ?? "0.0",
          posterPath: details.posterPath ?? "",
          type: "Movie",
        ),
      );
    } else {
      details = await APIService().getTvShowDetail(id);
      return GestureDetector(
        onTap: () => GoRouter.of(context).push('/tv/$id'),
        child: _buildItemRow(
          title: details.name ?? "Unknown",
          date: "First Air: ${details.firstAirDate ?? 'N/A'}",
          rating: details.voteAverage?.toStringAsFixed(1) ?? "0.0",
          posterPath: details.posterPath ?? "",
          type: "TV Show",
        ),
      );
    }
  } catch (e) {
    return const SizedBox();
  }
}

// Clean helper method to build the Row UI
Widget _buildItemRow({
  required String title,
  required String date,
  required String rating,
  required String posterPath,
  required String type,
}) {
  return Row(
    children: [
      Container(
        height: 150,
        width: 100,
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://image.tmdb.org/t/p/w500$posterPath'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            Text(date,
                style: const TextStyle(color: Colors.white70, fontSize: 14)),
            Text("Rating: ⭐ $rating",
                style: const TextStyle(color: Colors.white70, fontSize: 14)),
            Text("Type: $type",
                style: const TextStyle(color: Colors.white70, fontSize: 14)),
          ],
        ),
      ),
      const Padding(
        padding: EdgeInsets.only(right: 15),
        child: Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16),
      ),
    ],
  );
}
