import 'package:crosstrack_italia/features/track/presentation/widget/comparison_button.dart';
import 'package:crosstrack_italia/features/track/presentation/widget/location_selector.dart';
import 'package:crosstrack_italia/features/track/presentation/widget/track_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrackSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildSelectionForm(
      BuildContext context,
    ) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TrackSelector(),
            LocationSelector(),
            16.verticalSpace,
            ComparisonButton(),
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Confronto Tracciati'),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: _buildSelectionForm(context),
      ),
    );
  }
}
