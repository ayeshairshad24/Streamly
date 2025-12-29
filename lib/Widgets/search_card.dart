import 'package:flutter/material.dart';
import '/Services/consts.dart';

/// I render a search result row with thumbnail, title, type and rating.
class SearchCard extends StatelessWidget {
  const SearchCard(this.title, this.image, this.popularRating, this.mediatype,
      {super.key});
  final String title;
  final ImageProvider image;
  final String popularRating;
  final String mediatype;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        margin: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 100,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                image: DecorationImage(fit: BoxFit.cover, image: image),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                  width: size.width - 150,
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    width: size.width - 150,
                    child: Row(
                      children: [
                        const Text(
                          'Media Type: ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          mediatype.toString().toUpperCase(),
                          style: TextStyle(
                            color: accentSecondary,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    )),
                Container(
                    margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    width: size.width - 150,
                    child: Row(
                      children: [
                        Text(
                          mediatype == 'person' ? 'Popularity: ' : 'Rating: ',
                          style: TextStyle(
                            color: accentSecondary,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          popularRating.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ));
  }
}
