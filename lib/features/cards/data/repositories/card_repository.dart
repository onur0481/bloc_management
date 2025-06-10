import 'package:bloc_management/core/base/base_repository.dart';
import 'package:bloc_management/features/cards/data/models/card_model.dart';

class CardRepository implements BaseRepository<CardModel> {
  // Dummy veri
  final List<CardModel> _dummyCards = [
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

  @override
  Future<List<CardModel>> getAll() async {
    // Simüle edilmiş network gecikmesi
    await Future.delayed(const Duration(seconds: 1));
    return _dummyCards;
  }

  @override
  Future<CardModel?> getById(int id) async {
    // Simüle edilmiş network gecikmesi
    await Future.delayed(const Duration(milliseconds: 500));
    return _dummyCards.firstWhere((card) => card.id == id);
  }

  @override
  Future<void> create(CardModel item) async {
    // Simüle edilmiş network gecikmesi
    await Future.delayed(const Duration(milliseconds: 500));
    _dummyCards.add(item);
  }

  @override
  Future<void> update(CardModel item) async {
    // Simüle edilmiş network gecikmesi
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _dummyCards.indexWhere((card) => card.id == item.id);
    if (index != -1) {
      _dummyCards[index] = item;
    }
  }

  @override
  Future<void> delete(int id) async {
    // Simüle edilmiş network gecikmesi
    await Future.delayed(const Duration(milliseconds: 500));
    _dummyCards.removeWhere((card) => card.id == id);
  }

  Future<num> getCardBalance(int cardId) async {
    // Simüle edilmiş network gecikmesi
    await Future.delayed(const Duration(milliseconds: 500));
    // Rastgele bakiye döndür
    return (cardId * 1000).toDouble();
  }
}
