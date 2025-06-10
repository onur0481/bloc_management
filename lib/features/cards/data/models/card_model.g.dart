// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CardModelImpl _$$CardModelImplFromJson(Map<String, dynamic> json) =>
    _$CardModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      cardType: json['cardType'] as String,
      cardNumber: json['cardNumber'] as String,
      expiryDate: json['expiryDate'] as String,
      cvv: json['cvv'] as String,
      isActive: json['isActive'] as bool? ?? false,
      isBlocked: json['isBlocked'] as bool? ?? false,
      notifications: (json['notifications'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      cardLogo: json['cardLogo'] as String,
      cardColor: json['cardColor'] as String,
      cardHolderName: json['cardHolderName'] as String,
    );

Map<String, dynamic> _$$CardModelImplToJson(_$CardModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cardType': instance.cardType,
      'cardNumber': instance.cardNumber,
      'expiryDate': instance.expiryDate,
      'cvv': instance.cvv,
      'isActive': instance.isActive,
      'isBlocked': instance.isBlocked,
      'notifications': instance.notifications,
      'cardLogo': instance.cardLogo,
      'cardColor': instance.cardColor,
      'cardHolderName': instance.cardHolderName,
    };
