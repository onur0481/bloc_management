import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_management/features/profile/domain/bloc/profile_bloc.dart';
import 'package:bloc_management/features/profile/domain/bloc/profile_event.dart';
import 'package:bloc_management/features/profile/domain/bloc/profile_state.dart';
import 'package:bloc_management/features/profile/data/repositories/profile_repository.dart';
import 'package:bloc_management/features/profile/data/models/profile_model.dart';
import 'package:bloc_management/features/profile/data/models/profile_details_model.dart';
import 'package:bloc_management/core/base/base_state.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  group('ProfileBloc Tests', () {
    late ProfileBloc profileBloc;
    late ProfileRepository mockRepository;

    // Her test öncesi yeni bir ProfileBloc ve mock repository oluşturulur
    // Her test sonrası bloc kapatılır (memory leak'leri önlemek için)

    setUp(() {
      mockRepository = ProfileRepository();
      profileBloc = ProfileBloc(mockRepository);
    });

    tearDown(() {
      profileBloc.close();
    });

    test('initial state should be ProfileState with InitialState', () {
      expect(profileBloc.state.profileState, isA<InitialState<ProfileModel>>());
      expect(profileBloc.state.detailsState, isA<InitialState<ProfileDetailsModel>>());
    });

    // build: Test için kullanılacak bloc'u oluşturur
    // act: Bloc'a gönderilecek event'i tanımlar
    // wait: Asenkron işlemlerin tamamlanmasını bekler
    // expect: Beklenen state değişikliklerini tanımlar

    blocTest<ProfileBloc, ProfileState>(
      'emits [LoadingState, LoadedState] when LoadProfileInfo is added',
      build: () => profileBloc,
      act: (bloc) => bloc.add(const LoadProfileInfo()),
      wait: const Duration(seconds: 2),
      expect: () => [
        isA<ProfileState>().having(
          (state) => state.profileState,
          'profileState',
          isA<LoadingState<ProfileModel>>(),
        ),
        isA<ProfileState>().having(
          (state) => state.profileState,
          'profileState',
          isA<LoadedState<ProfileModel>>(),
        ),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [LoadingState, ErrorState] when LoadProfileInfo fails',
      build: () {
        mockRepository.setResponseType('error');
        return ProfileBloc(mockRepository);
      },
      act: (bloc) => bloc.add(const LoadProfileInfo()),
      wait: const Duration(seconds: 2),
      expect: () => [
        isA<ProfileState>().having(
          (state) => state.profileState,
          'profileState',
          isA<LoadingState<ProfileModel>>(),
        ),
        isA<ProfileState>().having(
          (state) => state.profileState,
          'profileState',
          isA<ErrorState<ProfileModel>>(),
        ),
      ],
    );

    // Mock Repository'yi "noContent" moduna ayarlar - Repository'nin boş içerik döndürmesini sağlar
    // LoadProfileDetails event'ini gönderir - Bloc'a profil detaylarını yükleme komutu verir
    // 2 saniye bekler - Asenkron işlemin tamamlanmasını bekler
    // İki state değişikliğini bekler:
    // İlk olarak LoadingState - Yükleme başladığında
    // Sonra NoContentState - İçerik bulunamadığında
    blocTest<ProfileBloc, ProfileState>(
      'emits [LoadingState, NoContentState] when LoadProfileInfo returns no content',
      build: () {
        mockRepository.setResponseType('noContent');
        return ProfileBloc(mockRepository);
      },
      act: (bloc) => bloc.add(const LoadProfileInfo()),
      wait: const Duration(seconds: 2),
      expect: () => [
        isA<ProfileState>().having(
          (state) => state.profileState,
          'profileState',
          isA<LoadingState<ProfileModel>>(),
        ),
        isA<ProfileState>().having(
          (state) => state.profileState,
          'profileState',
          isA<NoContentState<ProfileModel>>(),
        ),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [LoadingState, LoadedState] when LoadProfileDetails is added',
      build: () => profileBloc,
      act: (bloc) => bloc.add(const LoadProfileDetails()),
      wait: const Duration(seconds: 2),
      expect: () => [
        isA<ProfileState>().having(
          (state) => state.detailsState,
          'detailsState',
          isA<LoadingState<ProfileDetailsModel>>(),
        ),
        isA<ProfileState>().having(
          (state) => state.detailsState,
          'detailsState',
          isA<LoadedState<ProfileDetailsModel>>(),
        ),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [LoadingState, ErrorState] when LoadProfileDetails fails',
      build: () {
        mockRepository.setResponseType('error');
        return ProfileBloc(mockRepository);
      },
      act: (bloc) => bloc.add(const LoadProfileDetails()),
      wait: const Duration(seconds: 2),
      expect: () => [
        isA<ProfileState>().having(
          (state) => state.detailsState,
          'detailsState',
          isA<LoadingState<ProfileDetailsModel>>(),
        ),
        isA<ProfileState>().having(
          (state) => state.detailsState,
          'detailsState',
          isA<ErrorState<ProfileDetailsModel>>(),
        ),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [LoadingState, NoContentState] when LoadProfileDetails returns no content',
      build: () {
        mockRepository.setResponseType('noContent');
        return ProfileBloc(mockRepository);
      },
      act: (bloc) => bloc.add(const LoadProfileDetails()),
      wait: const Duration(seconds: 2),
      expect: () => [
        isA<ProfileState>().having(
          (state) => state.detailsState,
          'detailsState',
          isA<LoadingState<ProfileDetailsModel>>(),
        ),
        isA<ProfileState>().having(
          (state) => state.detailsState,
          'detailsState',
          isA<NoContentState<ProfileDetailsModel>>(),
        ),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [LoadingState, LoadedState] when TestProfileSuccess is added',
      build: () => profileBloc,
      act: (bloc) => bloc.add(const TestProfileSuccess()),
      wait: const Duration(seconds: 2),
      expect: () => [
        isA<ProfileState>().having(
          (state) => state.profileState,
          'profileState',
          isA<LoadingState<ProfileModel>>(),
        ),
        isA<ProfileState>().having(
          (state) => state.profileState,
          'profileState',
          isA<LoadedState<ProfileModel>>(),
        ),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [LoadingState, ErrorState] when TestProfileError is added',
      build: () => profileBloc,
      act: (bloc) => bloc.add(const TestProfileError()),
      wait: const Duration(seconds: 2),
      expect: () => [
        isA<ProfileState>().having(
          (state) => state.profileState,
          'profileState',
          isA<LoadingState<ProfileModel>>(),
        ),
        isA<ProfileState>().having(
          (state) => state.profileState,
          'profileState',
          isA<ErrorState<ProfileModel>>(),
        ),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [LoadingState, NoContentState] when TestProfileNoContent is added',
      build: () => profileBloc,
      act: (bloc) => bloc.add(const TestProfileNoContent()),
      wait: const Duration(seconds: 2),
      expect: () => [
        isA<ProfileState>().having(
          (state) => state.profileState,
          'profileState',
          isA<LoadingState<ProfileModel>>(),
        ),
        isA<ProfileState>().having(
          (state) => state.profileState,
          'profileState',
          isA<NoContentState<ProfileModel>>(),
        ),
      ],
    );
  });
}
