import 'package:fazakir/core/utils/func/helper_funcs.dart';
import 'package:flutter/material.dart';

class QuranTextHighlighter extends StatelessWidget {
  final String query;
  final String ayah;
  final TextStyle mainStyle;
  final Color highlightColor;

  const QuranTextHighlighter({
    super.key,
    required this.query,
    required this.ayah,
    required this.mainStyle,
    required this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    // Normalize both the query and the ayah
    String normalizedQuery = removeTashkeels(query);
    String normalizedAyah = removeTashkeels(ayah);

    // Build the map from normalized to original indices
    Map<int, int> normalizedToOriginalMap = buildNormalizedToOriginalMap(ayah);

    List<TextSpan> spans = [];
    int startIndex = 0;

    while (startIndex < normalizedAyah.length) {
      // Find the first occurrence of the query in the normalized ayah
      int matchIndex = normalizedAyah.indexOf(normalizedQuery, startIndex);

      // If no match is found, add the rest of the text and break
      if (matchIndex == -1) {
        spans.add(TextSpan(
            text: ayah
                .substring(normalizedToOriginalMap[startIndex] ?? startIndex)));
        break;
      }

      // Add the unhighlighted text before the match
      if (matchIndex > startIndex) {
        spans.add(TextSpan(
            text: ayah.substring(
                normalizedToOriginalMap[startIndex] ?? startIndex,
                normalizedToOriginalMap[matchIndex] ?? matchIndex)));
      }

      // Add the highlighted text (for the matched query)
      int matchEnd = matchIndex + normalizedQuery.length;
      spans.add(TextSpan(
        text: ayah.substring(normalizedToOriginalMap[matchIndex] ?? matchIndex,
            normalizedToOriginalMap[matchEnd - 1]! + 1),
        style: mainStyle.copyWith(color: highlightColor),
      ));

      // Move the startIndex forward to continue searching
      startIndex = matchEnd;
    }

    return Text.rich(
      TextSpan(children: spans, style: mainStyle),
    );
  }

  // Build the normalized to original map using custom removeTashkeels
  Map<int, int> buildNormalizedToOriginalMap(String original) {
    Map<int, int> map = {};
    int normalizedIndex = 0;

    for (int i = 0; i < original.length; i++) {
      // Normalize the current character
      String currentChar = original[i];
      String normalizedChar = removeTashkeels(currentChar);

      // Only map characters that remain after normalization (non-tashkeel)
      if (normalizedChar.isNotEmpty && normalizedChar != currentChar) {
        map[normalizedIndex] = i;
        normalizedIndex++;
      } else if (normalizedChar == currentChar) {
        map[normalizedIndex] = i;
        normalizedIndex++;
      }
    }

    return map;
  }
}
