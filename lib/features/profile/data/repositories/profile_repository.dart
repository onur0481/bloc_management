import 'package:bloc_management/core/models/api_response.dart';
import 'package:bloc_management/features/profile/data/models/profile_model.dart';

class ProfileRepository {
  // Simüle edilmiş API çağrısı
  Future<ApiResponse<ProfileModel>> getProfile() async {
    try {
      // API çağrısı simülasyonu
      await Future.delayed(const Duration(seconds: 1));

      // Başarılı durum
      return ApiResponse.success(
        ProfileModel(
          id: 1,
          name: 'John Doe',
          email: 'john@example.com',
          phone: '+90 555 123 4567',
          avatar: 'https://example.com/avatar.jpg',
          isVerified: true,
        ),
      );
    } catch (e) {
      return ApiResponse.error('Profil bilgileri alınamadı');
    }
  }

  // Simüle edilmiş hata durumu
  Future<ApiResponse<ProfileModel>> getProfileWithError() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      throw Exception('Sunucu hatası');
    } catch (e) {
      return ApiResponse.error(
        'Profil bilgileri alınamadı',
        type: 'popup',
      );
    }
  }
}
