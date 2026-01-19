import 'package:crosstrack_italia/features/user_info/providers/user_info_providers.dart';
import 'package:crosstrack_italia/features/track/presentation/track_selection_screen.dart';
import 'package:crosstrack_italia/features/user_info/presentation/favorite_tracks_screen.dart';
import 'package:crosstrack_italia/features/user_info/presentation/owned_tracks_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackAction extends StatelessWidget {
  const TrackAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.h),
            child: Text(
              'Tracciati',
              style: GoogleFonts.poppins(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
                letterSpacing: -0.5,
              ),
            ),
          ),
          
          // Action Cards
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildActionCard(
                  context: context,
                  icon: Icons.compare_arrows_rounded,
                  title: 'Confronto Tracciati',
                  subtitle: 'Confronta due tracciati fianco a fianco',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrackSelectionScreen(),
                      ),
                    );
                  },
                ),
                
                SizedBox(height: 12.h),
                
                _buildActionCard(
                  context: context,
                  icon: Icons.favorite_rounded,
                  title: 'Tracciati Preferiti',
                  subtitle: 'I tuoi tracciati salvati',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavoriteTracksScreen(),
                      ),
                    );
                  },
                ),
                
                // Owner-only section
                Consumer(
                  builder: (context, ref, child) {
                    final isOwner = ref.watch(isOwnerProvider);
                    if (!isOwner) return const SizedBox.shrink();
                    
                    return Column(
                      children: [
                        SizedBox(height: 12.h),
                        _buildActionCard(
                          context: context,
                          icon: Icons.edit_road_rounded,
                          title: 'Gestione Tracciati',
                          subtitle: 'Modifica i tracciati che gestisci',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OwnedTracksScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
                
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              // Icon container
              Container(
                width: 56.r,
                height: 56.r,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 28.r,
                ),
              ),
              SizedBox(width: 16.w),
              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: -0.3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
              // Arrow
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 20.r,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
