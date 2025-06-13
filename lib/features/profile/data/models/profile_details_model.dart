import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_details_model.freezed.dart';
part 'profile_details_model.g.dart';

@freezed
class ProfileDetailsModel with _$ProfileDetailsModel {
  const factory ProfileDetailsModel({
    required String address,
    required String city,
    required String country,
    required String bio,
  }) = _ProfileDetailsModel;

  factory ProfileDetailsModel.fromJson(Map<String, dynamic> json) => _$ProfileDetailsModelFromJson(json);
}
