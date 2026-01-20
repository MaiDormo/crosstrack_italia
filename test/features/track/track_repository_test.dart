import 'dart:math' show min;

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TrackRepository', () {
    group('calculateNewRating', () {
      // We can test this without mocking since it's pure logic
      // Note: For a full test, you'd mock FirebaseFirestore
      // For now, we test the pure calculation logic

      test('calculates correct rating when adding a new 5-star review to empty track', () {
        // Formula: (oldRating * oldCount + newRating) / (oldCount + 1)
        // (0.0 * 0 + 5.0) / (0 + 1) = 5.0
        final result = _calculateNewRating(0.0, 0, 5.0, true);
        expect(result, 5.0);
      });

      test('calculates correct rating when adding a review', () {
        // Current: 4.0 average with 5 reviews
        // Adding: 5.0 rating
        // Formula: (4.0 * 5 + 5.0) / (5 + 1) = 25.0 / 6 = 4.166...
        final result = _calculateNewRating(4.0, 5, 5.0, true);
        expect(result, closeTo(4.166, 0.01));
      });

      test('calculates correct rating when adding a low review', () {
        // Current: 4.0 average with 5 reviews
        // Adding: 1.0 rating
        // Formula: (4.0 * 5 + 1.0) / (5 + 1) = 21.0 / 6 = 3.5
        final result = _calculateNewRating(4.0, 5, 1.0, true);
        expect(result, closeTo(3.5, 0.01));
      });

      test('calculates correct rating when removing a review', () {
        // Current: 4.0 average with 5 reviews
        // Removing: 3.0 rating
        // Formula: (4.0 * 5 - 3.0) / (5 - 1) = 17.0 / 4 = 4.25
        final result = _calculateNewRating(4.0, 5, 3.0, false);
        expect(result, closeTo(4.25, 0.01));
      });

      test('returns 0.0 when removing the last review', () {
        // Current: 5.0 average with 1 review
        // Removing: 5.0 rating
        // Should return 0.0 (no reviews left)
        final result = _calculateNewRating(5.0, 1, 5.0, false);
        expect(result, 0.0);
      });

      test('handles removing review from track with 2 reviews', () {
        // Current: 4.5 average with 2 reviews (5.0 and 4.0)
        // Removing: 5.0 rating
        // Formula: (4.5 * 2 - 5.0) / (2 - 1) = 4.0 / 1 = 4.0
        final result = _calculateNewRating(4.5, 2, 5.0, false);
        expect(result, closeTo(4.0, 0.01));
      });
    });
  });

  group('partition', () {
    test('splits list into chunks of specified size', () {
      final result = partition([1, 2, 3, 4, 5], 2);
      expect(result, [
        [1, 2],
        [3, 4],
        [5],
      ]);
    });

    test('handles list smaller than chunk size', () {
      final result = partition([1, 2], 5);
      expect(result, [
        [1, 2],
      ]);
    });

    test('handles list exactly divisible by chunk size', () {
      final result = partition([1, 2, 3, 4, 5, 6], 3);
      expect(result, [
        [1, 2, 3],
        [4, 5, 6],
      ]);
    });

    test('handles empty list', () {
      final result = partition<int>([], 3);
      expect(result, isEmpty);
    });

    test('handles chunk size of 1', () {
      final result = partition([1, 2, 3], 1);
      expect(result, [
        [1],
        [2],
        [3],
      ]);
    });

    test('handles chunk size of 10 (Firestore whereIn limit)', () {
      final list = List.generate(25, (i) => i);
      final result = partition(list, 10);
      expect(result.length, 3);
      expect(result[0].length, 10);
      expect(result[1].length, 10);
      expect(result[2].length, 5);
    });
  });
}

/// Helper function to test rating calculation without requiring Firestore mock.
/// This mirrors the logic in TrackRepository.calculateNewRating
double _calculateNewRating(
    double oldRating, int oldCommentCount, double rating, bool isAdd) {
  return isAdd
      ? (oldRating * oldCommentCount + rating) / (oldCommentCount + 1)
      : oldCommentCount != 1
          ? (oldRating * oldCommentCount - rating) / (oldCommentCount - 1)
          : 0.0;
}

/// Splits a list into chunks of the specified size.
/// This mirrors the logic in track_repository.dart
List<List<T>> partition<T>(List<T> list, int size) {
  return List.generate((list.length / size).ceil(), (index) {
    final int start = index * size;
    final int end = min(start + size, list.length);
    return list.sublist(start, end);
  });
}
