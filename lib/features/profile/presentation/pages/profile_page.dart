import 'package:auto_route/auto_route.dart';
import 'package:bloc_management/core/base/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_management/features/profile/domain/bloc/profile_bloc.dart';
import 'package:bloc_management/features/profile/domain/bloc/profile_event.dart';
import 'package:bloc_management/features/profile/domain/bloc/profile_state.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profil Bilgileri
            BlocBuilder<ProfileBloc, ProfileState>(
              buildWhen: (previous, current) => previous.profileState != current.profileState,
              builder: (context, state) {
                final profileState = state.profileState;
                if (profileState is LoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (profileState is LoadedState) {
                  final profile = profileState.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (profile?.avatar != null)
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(profile!.avatar!),
                        ),
                      const SizedBox(height: 16),
                      Text(
                        profile?.name ?? '',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        profile?.email ?? '',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        profile?.phone ?? '',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 8),
                      if (profile?.isVerified ?? false)
                        const Chip(
                          label: Text('Doğrulanmış'),
                          backgroundColor: Colors.green,
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                    ],
                  );
                }
                if (profileState is ErrorState) {
                  return Text(
                    profileState.message ?? '',
                    style: const TextStyle(color: Colors.red),
                  );
                }
                if (profileState is NoContentState) return const Center(child: Text('Profil bilgileri bulunamadı'));
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 24),
            // Test Butonları
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<ProfileBloc>().add(const TestProfileError());
                      },
                      child: const Text('Error Test'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<ProfileBloc>().add(const TestProfileNoContent());
                      },
                      child: const Text('No Content Test'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<ProfileBloc>().add(const TestProfileSuccess());
                      },
                      child: const Text('Success Test'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Profil Detayları
            BlocBuilder<ProfileBloc, ProfileState>(
              buildWhen: (previous, current) => previous.detailsState != current.detailsState,
              builder: (context, state) {
                final detailsState = state.detailsState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: detailsState is LoadingState
                          ? null
                          : () {
                              context.read<ProfileBloc>().add(const LoadProfileDetails());
                            },
                      child: detailsState is LoadingState
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Detayları Göster'),
                    ),
                    if (detailsState is LoadedState) ...[
                      const SizedBox(height: 16),
                      const Text(
                        'Detay Bilgileri',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text('Adres: ${detailsState.data?.address}'),
                      Text('Şehir: ${detailsState.data?.city}'),
                      Text('Ülke: ${detailsState.data?.country}'),
                      Text('Biyografi: ${detailsState.data?.bio}'),
                    ],
                    if (detailsState is ErrorState)
                      Builder(
                        builder: (context) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Hata'),
                                content: Text(detailsState.message ?? ''),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Tamam'),
                                  ),
                                ],
                              ),
                            );
                          });
                          return const SizedBox.shrink();
                        },
                      ),
                    if (detailsState is NoContentState) const Center(child: Text('Detay bilgileri bulunamadı')),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
