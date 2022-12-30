import 'package:flutter/material.dart';
import 'package:my_restaurant/shared/model/customer_review_model.dart';
import 'package:my_restaurant/shared/styling/my_text_style.dart';

class ReviewCard extends StatelessWidget {
  final CustomerReview review;
  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      minVerticalPadding: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xFF1D63C8)),
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        review.name,
        style: MyTextStyle.subTitle(),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 2),
          Text(
            review.date,
            style: MyTextStyle.regular(color: Colors.grey.shade400),
          ),
          const SizedBox(height: 4),
          Text(
            review.review,
            style: MyTextStyle.regular(),
          ),
        ],
      ),
    );
  }
}
