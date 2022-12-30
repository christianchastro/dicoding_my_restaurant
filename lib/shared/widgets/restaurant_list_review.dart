import 'package:flutter/material.dart';
import 'package:my_restaurant/shared/model/customer_review_model.dart';
import 'package:my_restaurant/shared/provider/restaurant_provider.dart';
import 'package:my_restaurant/shared/styling/my_text_style.dart';
import 'package:my_restaurant/shared/widgets/review_card.dart';
import 'package:provider/provider.dart';

class RestaurantListReview extends StatelessWidget {
  final String idRestaurant;
  final List<CustomerReview> reviews;
  RestaurantListReview({
    super.key,
    required this.reviews,
    required this.idRestaurant,
  });

  final TextEditingController _reviewController = TextEditingController(),
      _nameController = TextEditingController();

  Widget _formReview(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF1D63C8),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tambah Review",
            style: MyTextStyle.subTitle(fontSize: 12),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _nameController,
            cursorColor: const Color(0xFFF4A734),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFF1D63C8),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFF1D63C8),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusColor: const Color(0xFFF4A734),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFFF4A734),
                ),
              ),
              labelText: "Nama Kamu",
              labelStyle: MyTextStyle.regular(),
              floatingLabelStyle:
                  MyTextStyle.regular(color: const Color(0xFFF4A734)),
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _reviewController,
            cursorColor: const Color(0xFFF4A734),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFF1D63C8),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFF1D63C8),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusColor: const Color(0xFFF4A734),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFFF4A734),
                ),
              ),
              labelText: "Review Kamu",
              labelStyle: MyTextStyle.regular(),
              floatingLabelStyle:
                  MyTextStyle.regular(color: const Color(0xFFF4A734)),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF4A734),
              minimumSize: const Size(double.infinity, 34),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              if (_reviewController.text.isNotEmpty &&
                  _nameController.text.isNotEmpty) {
                Provider.of<RestaurantProvider>(context, listen: false)
                    .postCustomerReview(idRestaurant, _nameController.text,
                        _reviewController.text);
                FocusScope.of(context).unfocus();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Tolong masukan nama dan review kamu"),
                  ),
                );
              }
            },
            child: Text(
              "Kirim Review",
              style: MyTextStyle.subTitle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Reviews",
            style: MyTextStyle.subTitle(),
          ),
          const SizedBox(height: 10),
          _formReview(context),
          const SizedBox(height: 10),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: reviews.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, index) => ReviewCard(review: reviews[index]),
          ),
        ],
      ),
    );
  }
}
