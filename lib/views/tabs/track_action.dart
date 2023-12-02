import 'package:crosstrack_italia/features/track/presentation/track_selection_screen.dart';
import 'package:crosstrack_italia/features/user_info/presentation/favorite_tracks_screen.dart';
import 'package:flutter/material.dart';

class TrackAction extends StatelessWidget {
  const TrackAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          color: Theme.of(context).colorScheme.secondary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: "track_selection_screen",
                child: IconButton(
                  icon: Icon(
                    Icons.compare_arrows,
                    size: 50,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TrackSelectionScreen()),
                    );
                  },
                ),
              ),
              Hero(
                tag: "favorite_tracks_screen",
                child: IconButton(
                  icon: Icon(
                    Icons.favorite,
                    size: 50,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FavoriteTracksScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
