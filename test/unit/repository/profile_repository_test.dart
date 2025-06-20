import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_management/features/profile/data/repositories/profile_repository.dart';
import 'package:bloc_management/core/models/api_response.dart';
import 'package:bloc_management/features/profile/data/models/profile_model.dart';
import 'package:bloc_management/features/profile/data/models/profile_details_model.dart';

void main() {
  late ProfileRepository repository;

  setUp(() {
    repository = ProfileRepository();
  });

  group('ProfileRepository', () {
    group('getProfile', () {
      test('başarılı durumda profil modeli döner', () async {
        final result = await repository.getProfile();
        expect(result, isA<ApiResponseSuccess<ProfileModel>>());
        final data = (result as ApiResponseSuccess<ProfileModel>).data;
        expect(data, isA<ProfileModel>());
        expect(data.name, 'John Doe');
        expect(data.email, 'john@example.com');
      });

      test('hata durumunda error döner', () async {
        repository.setResponseType('error');
        final result = await repository.getProfile();
        expect(result, isA<ApiResponseError<ProfileModel>>());
        final message = (result as ApiResponseError<ProfileModel>).message;
        expect(message, isNotNull);
      });

      test('noContent durumunda noContent döner', () async {
        repository.setResponseType('noContent');
        final result = await repository.getProfile();
        expect(result, isA<ApiResponseNoContent<ProfileModel>>());
      });
    });

    group('getProfileDetails', () {
      test('başarılı durumda profil detay modeli döner', () async {
        final result = await repository.getProfileDetails();
        expect(result, isA<ApiResponseSuccess<ProfileDetailsModel>>());
        final data = (result as ApiResponseSuccess<ProfileDetailsModel>).data;
        expect(data, isA<ProfileDetailsModel>());
        expect(data.city, 'İstanbul');
        expect(data.country, 'Türkiye');
      });

      test('hata durumunda error döner', () async {
        repository.setResponseType('error');
        final result = await repository.getProfileDetails();
        expect(result, isA<ApiResponseError<ProfileDetailsModel>>());
        final message = (result as ApiResponseError<ProfileDetailsModel>).message;
        expect(message, isNotNull);
      });

      test('noContent durumunda noContent döner', () async {
        repository.setResponseType('noContent');
        final result = await repository.getProfileDetails();
        expect(result, isA<ApiResponseNoContent<ProfileDetailsModel>>());
      });
    });
  });
}
