import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_restaurant/shared/api/api_service.dart';
import 'package:my_restaurant/shared/model/restaurant_model.dart';

import 'restaurants_provider_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Parsing json to Restaurant Model', () {
    MockClient client = MockClient();
    String detailResponse =
        '{"id": "1","name": "Test Restaurant Name","description": "Test Description","pictureId": "Gambar Redtaurant","city": "Bandung","address": "Jalan Bandung 123","rating": 5}';
    test('Should contain Restaurant data when parsing completed', () async {
      when(
        client.get(ApiService.stringToUri("${ApiService.baseUrl}detail/1")),
      ).thenAnswer((_) async => http.Response(detailResponse, 200));
      final response = await client
          .get(ApiService.stringToUri("${ApiService.baseUrl}detail/1"));
      expect(RestaurantModel.fromJson(json.decode(response.body)),
          isA<RestaurantModel>());
    });

    test('Should contain ID Restaurant equals 1', () async {
      when(
        client.get(ApiService.stringToUri("${ApiService.baseUrl}detail/1")),
      ).thenAnswer((_) async => http.Response(detailResponse, 200));
      final response = await client
          .get(ApiService.stringToUri("${ApiService.baseUrl}detail/1"));
      expect(
          RestaurantModel.fromJson(json.decode(response.body)).id, equals("1"));
    });
  });
}
