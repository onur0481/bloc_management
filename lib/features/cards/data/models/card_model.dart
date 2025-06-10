import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_model.freezed.dart';
part 'card_model.g.dart';

@freezed
class CardModel with _$CardModel {
  const factory CardModel({
    required int id,
    required String name,
    required String cardType,
    required String cardNumber,
    required String expiryDate,
    required String cvv,
    @Default(false) bool isActive,
    @Default(false) bool isBlocked,
    @Default([]) List<String> notifications,
    required String cardLogo,
    required String cardColor,
    required String cardHolderName,
  }) = _CardModel;

  factory CardModel.fromJson(Map<String, dynamic> json) => _$CardModelFromJson(json);
}
