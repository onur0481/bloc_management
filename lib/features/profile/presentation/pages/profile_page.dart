import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_management/features/profile/domain/bloc/profile_bloc.dart';
import 'package:bloc_management/features/profile/domain/bloc/profile_event.dart';
import 'package:bloc_management/features/profile/domain/bloc/profile_state.dart';

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
              buildWhen: (previous, current) => previous.infoState != current.infoState,
              builder: (context, state) {
                final infoState = state.infoState;
                if (infoState is ProfileInfoLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (infoState is ProfileInfoLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (infoState.profile.avatar != null)
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(infoState.profile.avatar!),
                        ),
                      const SizedBox(height: 16),
                      Text(
                        infoState.profile.name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        infoState.profile.email,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        infoState.profile.phone,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 8),
                      if (infoState.profile.isVerified)
                        const Chip(
                          label: Text('Doğrulanmış'),
                          backgroundColor: Colors.green,
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                    ],
                  );
                }
                if (infoState is ProfileInfoError) {
                  return Text(
                    infoState.message,
                    style: const TextStyle(color: Colors.red),
                  );
                }
                return const SizedBox.shrink();
              },
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
                      onPressed: detailsState is ProfileDetailsLoading
                          ? null
                          : () {
                              context.read<ProfileBloc>().add(const LoadProfileDetails());
                            },
                      child: detailsState is ProfileDetailsLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Detayları Göster'),
                    ),
                    if (detailsState is ProfileDetailsLoaded) ...[
                      const SizedBox(height: 16),
                      const Text(
                        'Detay Bilgileri',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text('Adres: ${detailsState.details.address}'),
                      Text('Şehir: ${detailsState.details.city}'),
                      Text('Ülke: ${detailsState.details.country}'),
                      Text('Biyografi: ${detailsState.details.bio}'),
                    ],
                    if (detailsState is ProfileDetailsError)
                      Builder(
                        builder: (context) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Hata'),
                                content: Text(detailsState.message),
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
