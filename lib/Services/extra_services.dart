import 'package:flutter/material.dart';
import '/Services/auth.dart';
import 'package:url_launcher/url_launcher.dart';

/// Student Note:
/// Helper function to launch a URL in the browser (e.g. YouTube trailer).
Future<void> launchUrlHelper(String url) async {
  final Uri url0 = Uri.parse(url);
  if (!await launchUrl(url0)) {
    throw Exception('Could not launch $url0');
  }
}

/// Student Note:
/// Show a dialog to add an item to the watchlist.
/// I use a simple Dialog with rows for each status.
void showWatchlistDialog(BuildContext context, String id, String mediaType) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xFF12121C).withValues(alpha: 0.95),
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Select Watchlist",
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                color: Colors.white.withValues(alpha: 0.5),
              ),
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  FireBaseServices().addWatching(id, "Watching", mediaType);
                  Navigator.pop(context);
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.play_circle_rounded,
                      color: Color(0xFF16F66A),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Watching",
                      style: TextStyle(
                        color: Color(0xFF16F66A),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  FireBaseServices().addWatching(id, "Completed", mediaType);
                  Navigator.pop(context);
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xFF36A5D0),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Completed",
                      style: TextStyle(
                        color: Color(0xFF36A5D0),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  FireBaseServices().addWatching(id, "On-Hold", mediaType);
                  Navigator.pop(context);
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.pause_rounded,
                      color: Color(0xFFDAC22E),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text("On Hold", style: TextStyle(color: Color(0xFFDAC22E)))
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  FireBaseServices().addWatching(id, "Dropped", mediaType);
                  Navigator.pop(context);
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.delete_rounded,
                      color: Color(0xFFE52E5C),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text("Dropped", style: TextStyle(color: Color(0xFFE52E5C)))
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
