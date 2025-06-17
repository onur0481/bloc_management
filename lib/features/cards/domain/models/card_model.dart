class CardModel {
  final int id;
  final String name;
  final String cardNumber;
  final String cardType;
  final num? balance;
  final bool isActive;
  final DateTime lastPinChange;
  final bool notificationsEnabled;

  CardModel({
    required this.id,
    required this.name,
    required this.cardNumber,
    required this.cardType,
    this.balance,
    this.isActive = true,
    required this.lastPinChange,
    this.notificationsEnabled = true,
  });

  CardModel copyWith({
    int? id,
    String? name,
    String? cardNumber,
    String? cardType,
    num? balance,
    bool? isActive,
    DateTime? lastPinChange,
    bool? notificationsEnabled,
  }) {
    return CardModel(
      id: id ?? this.id,
      name: name ?? this.name,
      cardNumber: cardNumber ?? this.cardNumber,
      cardType: cardType ?? this.cardType,
      balance: balance ?? this.balance,
      isActive: isActive ?? this.isActive,
      lastPinChange: lastPinChange ?? this.lastPinChange,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}
