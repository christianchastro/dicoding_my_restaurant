import 'package:my_restaurant/shared/model/customer_review_model.dart';
import 'package:my_restaurant/shared/response/my_response.dart';

class ReviewsResponse extends MyResponse {
  final List<CustomerReview>? customerReviews;
  const ReviewsResponse({
    required bool error,
    required String message,
    this.customerReviews,
  }) : super(error, message);

  factory ReviewsResponse.fromJson(Map<String, dynamic> json) =>
      ReviewsResponse(
        error: json["error"] as bool,
        message: json["message"] as String,
        customerReviews: json["customerReviews"] == null
            ? null
            : List<CustomerReview>.from(
                json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews": customerReviews == null || customerReviews!.isEmpty
            ? null
            : List<dynamic>.from(customerReviews!.map((x) => x.toJson())),
      };
}
