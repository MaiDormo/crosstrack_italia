import 'package:crosstrack_italia/features/auth/providers/auth_providers.dart';
import 'package:crosstrack_italia/features/track/presentation/track_selection_screen.dart';
import 'package:crosstrack_italia/features/user_info/presentation/favorite_tracks_screen.dart';
import 'package:crosstrack_italia/features/user_info/presentation/owned_tracks_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrackAction extends StatelessWidget {
  const TrackAction({Key? key}) : super(key: key);

  Widget _buildElevatedButton({
    required IconData icon,
    required String label,
    required Color foregroudColor,
    required Color backgroundColor,
    required String heroTag,
    required VoidCallback onPressed,
  }) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          icon: Hero(
            tag: heroTag,
            child: Icon(
              icon,
              size: 50,
              color: foregroudColor,
            ),
          ),
          label: Text(
            label,
            style: TextStyle(
              fontSize: 18,
              color: foregroudColor,
            ),
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildElevatedButton(
              icon: Icons.compare_arrows,
              label: 'Confronto tracciati',
              foregroudColor: Theme.of(context).colorScheme.onPrimary,
              backgroundColor: Theme.of(context).colorScheme.primary,
              heroTag: "track_selection_screen",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TrackSelectionScreen()),
                );
              },
            ),
            _buildElevatedButton(
              icon: Icons.favorite,
              label: 'Tracciati Favoriti',
              foregroudColor: Theme.of(context).colorScheme.primary,
              backgroundColor: Colors.white,
              heroTag: "favorite_tracks_screen",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavoriteTracksScreen()),
                );
              },
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final isOwner = ref.watch(isOwnerProvider);
                return Visibility(
                  ///TODO: add correct condition
                  visible: isOwner,
                  child: _buildElevatedButton(
                    icon: Icons.info,
                    label: 'Gestione Tracciati',
                    foregroudColor: Theme.of(context).colorScheme.onPrimary,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    heroTag: "track_management_screen",
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OwnedTracksScreen(),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
