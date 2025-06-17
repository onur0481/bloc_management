import 'package:auto_route/auto_route.dart';
import 'package:bloc_management/core/widgets/base_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_bloc.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_event.dart';
import 'package:bloc_management/features/cards/domain/bloc/cards_state.dart';
import 'package:bloc_management/core/router/app_router.dart';
import 'package:bloc_management/features/cards/data/models/card_model.dart';
import 'package:bloc_management/core/base/base_state.dart';

@RoutePage()
class CardSettingsPage extends StatelessWidget {
  final int cardId;

  const CardSettingsPage({
    super.key,
    @PathParam('cardId') required this.cardId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<CardsBloc, CardsState>(
      listenWhen: (previous, current) {
        if (previous.cardsState is LoadedState<List<CardModel>> && current.cardsState is LoadedState<List<CardModel>>) {
          final prevList = (previous.cardsState as LoadedState<List<CardModel>>).data ?? [];
          final currList = (current.cardsState as LoadedState<List<CardModel>>).data ?? [];
          return prevList.length > currList.length;
        }
        return false;
      },
      listener: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.router.replaceAll([const CardsRoute()]);
        });
      },
      child: BaseBlocBuilder<CardsBloc, CardsState, List<CardModel>>(
        bloc: context.read<CardsBloc>(),
        stateSelector: (state) => state.cardsState,
        onLoaded: (cards) {
          final card = cards.firstWhere((c) => c.id == cardId);
          return Scaffold(
            appBar: AppBar(
              title: Text('${card.name} - Ayarlar'),
            ),
            body: ListView(
              children: [
                _buildSettingSection(
                  'Kart Bilgileri',
                  [
                    _buildSettingTile(
                      'Kart Adı',
                      card.name,
                      Icons.credit_card,
                      onTap: () {
                        // Kart adı değiştirme
                      },
                    ),
                    _buildSettingTile(
                      'Kart Numarası',
                      '**** **** **** 1234',
                      Icons.numbers,
                      onTap: () {
                        // Kart numarası görüntüleme
                      },
                    ),
                  ],
                ),
                _buildSettingSection(
                  'Güvenlik',
                  [
                    _buildSettingTile(
                      'PIN Değiştir',
                      'Son değişiklik: 01.01.2024',
                      Icons.lock,
                      onTap: () {
                        // PIN değiştirme
                      },
                    ),
                    _buildSettingTile(
                      'Bildirimler',
                      'Aktif',
                      Icons.notifications,
                      onTap: () {
                        // Bildirim ayarları
                      },
                    ),
                  ],
                ),
                _buildSettingSection(
                  'Diğer',
                  [
                    _buildSettingTile(
                      'Kartı Dondur',
                      'Kartı geçici olarak devre dışı bırak',
                      Icons.block,
                      onTap: () {
                        // Kart dondurma
                      },
                    ),
                    _buildSettingTile(
                      'Kartı Sil',
                      'Kartı kalıcı olarak sil',
                      Icons.delete,
                      textColor: Colors.red,
                      onTap: () => _showDeleteConfirmation(context),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSettingSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
        const Divider(),
      ],
    );
  }

  Widget _buildSettingTile(
    String title,
    String subtitle,
    IconData icon, {
    Color? textColor,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kartı Sil'),
        content: const Text(
          'Bu kartı kalıcı olarak silmek istediğinizden emin misiniz?',
        ),
        actions: [
          TextButton(
            onPressed: () => context.router.maybePop(),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              context.read<CardsBloc>().add(DeleteCard(cardId));
              context.router.maybePop();
              context.router.replaceAll([const CardsRoute()]);
            },
            child: const Text(
              'Sil',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
