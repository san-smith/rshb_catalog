import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final double totalRating;
  final int ratingCount;

  const Rating({
    Key key,
    this.totalRating,
    this.ratingCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _getRating(),
        SizedBox(width: 5),
        _getRatingCount(),
      ],
    );
  }

  Widget _getRating() {
    return Container(
      height: 22,
      width: 22,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: _getRatingColor(),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          _ratingToStr(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _getRatingCount() {
    return Text(
      '${_getTitle()}',
      style: TextStyle(
        color: Color(0xFF969696),
        fontSize: 10,
      ),
    );
  }

  String _ratingToStr() {
    if (totalRating == null || totalRating < 0.05) return '—';
    if (totalRating.truncate() == totalRating)
      return totalRating.toStringAsFixed(0);
    return totalRating.toStringAsFixed(1);
  }

  Color _getRatingColor() {
    if (totalRating <= 3) return Color(0xFFBDBDBD);
    if (totalRating >= 4) return Color(0xFF42AB44);
    return Color(0xFFD7A50C);
  }

  String _getTitle() {
    if (ratingCount == 0) return 'нет оценок';
    if (ratingCount % 10 == 1 && ratingCount % 100 != 11)
      return '$ratingCount оценка';
    if ([2, 3, 4].contains(ratingCount % 10) &&
        ![12, 13, 14].contains(ratingCount % 100)) return '$ratingCount оценки';
    return '$ratingCount оценок';
  }
}
