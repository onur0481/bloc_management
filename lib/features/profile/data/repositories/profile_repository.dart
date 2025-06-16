import 'package:bloc_management/core/base/base_repository_mixin.dart';
import 'package:bloc_management/core/models/api_response.dart';
import 'package:bloc_management/features/profile/data/models/profile_model.dart';
import 'package:bloc_management/features/profile/data/models/profile_details_model.dart';

class ProfileRepository with BaseRepositoryMixin {
  // Test için response type parametresi
  String? _responseType;

  void setResponseType(String type) {
    _responseType = type;
  }

  Future<ApiResponse<ProfileModel>> getProfile() async {
    // API çağrısı simülasyonu
    await Future.delayed(const Duration(seconds: 1));

    // Test durumuna göre farklı yanıtlar döndür
    if (_responseType == 'error') {
      return const ApiResponse.error('Test hata mesajı');
    } else if (_responseType == 'noContent') {
      return const ApiResponse.noContent();
    }

    // API yanıtını simüle ediyoruz
    final response = {
      'id': 1,
      'name': 'John Doe',
      'email': 'john@example.com',
      'phone': '+90 555 123 4567',
      'avatar': 'https://i.pravatar.cc/150?img=1',
      'isVerified': true,
    };

    return handleResponse<ProfileModel>(
      parseData: () => ProfileModel.fromJson(response),
      errorMessage: 'Profil bilgileri alınamadı',
    );
  }

  Future<ApiResponse<ProfileDetailsModel>> getProfileDetails() async {
    // API çağrısı simülasyonu
    await Future.delayed(const Duration(seconds: 1));

    // Test durumuna göre farklı yanıtlar döndür
    if (_responseType == 'error') {
      return const ApiResponse.error('Test hata mesajı');
    } else if (_responseType == 'noContent') {
      return const ApiResponse.noContent();
    }

    // API yanıtını simüle ediyoruz
    final response = {
      'address': 'Atatürk Cad. No:123',
      'city': 'İstanbul',
      'country': 'Türkiye',
      'bio': 'Flutter Developers',
    };

    return handleResponse<ProfileDetailsModel>(
      parseData: () => ProfileDetailsModel.fromJson(response),
      errorMessage: 'Profil detayları alınamadı',
    );
  }
}
