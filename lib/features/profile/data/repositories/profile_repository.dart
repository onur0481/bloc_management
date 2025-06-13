import 'package:bloc_management/core/base/base_repository_mixin.dart';
import 'package:bloc_management/core/models/api_response.dart';
import 'package:bloc_management/features/profile/data/models/profile_model.dart';
import 'package:bloc_management/features/profile/data/models/profile_details_model.dart';

class ProfileRepository with BaseRepositoryMixin {
  Future<ApiResponse<ProfileModel>> getProfile() async {
    // API çağrısı simülasyonu
    await Future.delayed(const Duration(seconds: 1));

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

    // API yanıtını simüle ediyoruz
    final response = {
      'address': 'Atatürk Cad. No:123',
      'city': 'İstanbul',
      'country': 'Türkiye',
      'bio': 'Flutter Developer',
    };

    return handleResponse<ProfileDetailsModel>(
      parseData: () => ProfileDetailsModel.fromJson(response),
      errorMessage: 'Profil detayları alınamadı',
    );
  }
}
