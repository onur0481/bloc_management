import 'package:bloc_management/core/base/base_repository_mixin.dart';
import 'package:bloc_management/core/models/api_response.dart';
import 'package:bloc_management/features/cards/data/models/card_model.dart';

class CardRepository with BaseRepositoryMixin {
  // Test için response type parametresi
  String? _responseType;

  // Kartları tutacak private liste
  final List<CardModel> _cards = [
    CardModel(
      id: 1,
      name: 'Ana Hesap',
      cardType: 'bank',
      cardNumber: '**** **** **** 1234',
      expiryDate: '12/25',
      cvv: '123',
      isActive: true,
      cardLogo: 'assets/images/bank_logo.png',
      cardColor: '#2196F3',
      cardHolderName: 'John Doe',
    ),
    CardModel(
      id: 2,
      name: 'Yedek Hesap',
      cardType: 'bank',
      cardNumber: '**** **** **** 5678',
      expiryDate: '12/25',
      cvv: '456',
      isActive: true,
      cardLogo: 'assets/images/bank_logo.png',
      cardColor: '#4CAF50',
      cardHolderName: 'John Doe',
    ),
    CardModel(
      id: 3,
      name: 'Market Kartı',
      cardType: 'brand',
      cardNumber: '**** **** **** 9012',
      expiryDate: '12/25',
      cvv: '789',
      isActive: true,
      cardLogo: 'assets/images/market_logo.png',
      cardColor: '#FF9800',
      cardHolderName: 'John Doe',
    ),
  ];

  void setResponseType(String type) {
    _responseType = type;
  }

  Future<ApiResponse<List<CardModel>>> getAllCards() async {
    // API çağrısı simülasyonu
    await Future.delayed(const Duration(seconds: 1));

    // Test durumuna göre farklı yanıtlar döndür
    if (_responseType == 'error') {
      return const ApiResponse.error('Test hata mesajı');
    } else if (_responseType == 'noContent') {
      return const ApiResponse.noContent();
    }

    return handleResponse<List<CardModel>>(
      parseData: () => _cards,
      errorMessage: 'Kartlar alınamadı',
    );
  }

  Future<ApiResponse<num>> getCardBalance(int cardId) async {
    // API çağrısı simülasyonu
    await Future.delayed(const Duration(milliseconds: 500));

    // Test durumuna göre farklı yanıtlar döndür
    if (_responseType == 'error') {
      return const ApiResponse.error('Test hata mesajı');
    } else if (_responseType == 'noContent') {
      return const ApiResponse.noContent();
    }

    // API yanıtını simüle ediyoruz
    final response = (cardId * 1000).toDouble();

    return handleResponse<num>(
      parseData: () => response,
      errorMessage: 'Kart bakiyesi alınamadı',
    );
  }

  Future<ApiResponse<void>> deleteCard(int cardId) async {
    // API çağrısı simülasyonu
    await Future.delayed(const Duration(milliseconds: 500));

    // Test durumuna göre farklı yanıtlar döndür
    if (_responseType == 'error') {
      return const ApiResponse.error('Test hata mesajı');
    } else if (_responseType == 'noContent') {
      return const ApiResponse.noContent();
    }

    // Kartı listeden sil
    _cards.removeWhere((card) => card.id == cardId);

    return handleResponse<void>(
      parseData: () {},
      errorMessage: 'Kart silinemedi',
    );
  }
}
