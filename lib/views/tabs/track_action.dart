import 'package:crosstrack_italia/features/user_info/providers/user_info_providers.dart';
import 'package:crosstrack_italia/features/track/presentation/track_selection_screen.dart';
import 'package:crosstrack_italia/features/user_info/presentation/favorite_tracks_screen.dart';
import 'package:crosstrack_italia/features/user_info/presentation/owned_tracks_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrackAction extends StatelessWidget {
  const TrackAction({Key? key}) : super(key: key);

  Widget _buildElevatedButton({
    required IconData icon,
    required String label,
    required Color foregroudColor,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(16.0).r,
        child: ElevatedButton.icon(
          icon: Icon(
            icon,
            size: 50.h,
            color: foregroudColor,
          ),
          label: Text(
            label,
            style: TextStyle(
              fontSize: 18.sp,
              color: foregroudColor,
            ),
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
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
      padding: const EdgeInsets.symmetric(vertical: 8.0).h,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildElevatedButton(
              icon: Icons.compare_arrows,
              label: 'Confronto Tracciati',
              foregroudColor: Theme.of(context).colorScheme.onSecondary,
              backgroundColor: Theme.of(context).colorScheme.secondary,
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
              label: 'Tracciati Preferiti',
              foregroudColor: Theme.of(context).colorScheme.secondary,
              backgroundColor: Colors.white,
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
                  visible: isOwner,
                  child: _buildElevatedButton(
                    icon: Icons.edit,
                    label: 'Gestione Tracciati',
                    foregroudColor: Theme.of(context).colorScheme.onSecondary,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
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
