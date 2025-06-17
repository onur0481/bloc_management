import 'package:auto_route/auto_route.dart';
import 'package:bloc_management/core/widgets/base_bloc_builder.dart';
import 'package:bloc_management/features/profile/data/models/profile_details_model.dart';
import 'package:bloc_management/features/profile/data/models/profile_model.dart';
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
            BaseBlocBuilder<ProfileBloc, ProfileState, ProfileModel>(
              bloc: context.read<ProfileBloc>(),
              buildWhen: (previous, current) => previous.profileState != current.profileState,
              stateSelector: (state) => state.profileState,
              onLoaded: (profile) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (profile.avatar != null)
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(profile.avatar!),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    profile.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    profile.email,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    profile.phone,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  if (profile.isVerified)
                    const Chip(
                      label: Text('Doğrulanmış'),
                      backgroundColor: Colors.green,
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                ],
              ),
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
            ElevatedButton(
              onPressed: () {
                context.read<ProfileBloc>().add(const LoadProfileDetails());
              },
              child: const Text('Detayları Göster'),
            ),
            BaseBlocBuilder<ProfileBloc, ProfileState, ProfileDetailsModel>(
              bloc: context.read<ProfileBloc>(),
              buildWhen: (previous, current) => previous.detailsState != current.detailsState,
              stateSelector: (state) => state.detailsState,
              onLoading: const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              ),
              onLoaded: (details) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Detay Bilgileri',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Adres: ${details.address}'),
                  Text('Şehir: ${details.city}'),
                  Text('Ülke: ${details.country}'),
                  Text('Biyografi: ${details.bio}'),
                ],
              ),
            ),
            // Profil Detayları
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
