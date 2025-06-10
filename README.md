# Bloc Management Projesi

Bu proje, Flutter uygulamalarında state management için BLoC (Business Logic Component) pattern'ini kullanarak geliştirilmiş bir örnek uygulamadır.

## 🚀 Özellikler

- Kart listeleme ve yönetimi
- Kart bakiyesi görüntüleme
- Kart filtreleme
- Sayfa yenileme
- Scroll optimizasyonu
- Hata yönetimi
- State yönetimi
- Event handling

## 📦 Kullanılan Paketler

- **flutter_bloc**: State management için temel BLoC paketi
- **bloc_concurrency**: Event'lerin işlenme stratejilerini yönetmek için
- **equatable**: State ve Event sınıflarının karşılaştırılması için

## 🏗️ Proje Yapısı

```
lib/
├── bloc/
│   ├── cards/
│   │   ├── cards_bloc.dart
│   │   ├── cards_event.dart
│   │   └── cards_state.dart
│   └── ...
├── models/
│   └── card.dart
├── repositories/
│   └── card_repository.dart
└── screens/
    └── cards_screen.dart
```

## 🔄 Olay Akışları

### Kart Yükleme
1. Uygulama başlatılır
2. LoadCards event'i tetiklenir
3. Kartlar paralel olarak yüklenir
4. Her kart için LoadCardBalance event'i tetiklenir
5. Bakiyeler sıralı olarak yüklenir

### Filtreleme
1. Kullanıcı filtreleme yapar
2. FilterCards event'i tetiklenir
3. Önceki filtreleme iptal edilir
4. Yeni filtreleme başlatılır
5. Sonuçlar gösterilir

## 🛠️ Kurulum

1. Projeyi klonlayın:
```bash
git clone https://github.com/onur0481/bloc_management.git
```

2. Bağımlılıkları yükleyin:
```bash
flutter pub get
```

3. Uygulamayı çalıştırın:
```bash
flutter run
```

## 📝 Kullanım

### Kart Listeleme
```dart
BlocBuilder<CardsBloc, CardsState>(
  builder: (context, state) {
    if (state is CardsLoading) {
      return CircularProgressIndicator();
    } else if (state is CardsLoaded) {
      return ListView.builder(
        itemCount: state.cards.length,
        itemBuilder: (context, index) {
          return CardItem(card: state.cards[index]);
        },
      );
    }
    return Container();
  },
);
```

### Kart Filtreleme
```dart
onFilterChanged(String filterType) {
  context.read<CardsBloc>().add(FilterCards(filterType));
}
```

## 🧪 Test

Projeyi test etmek için:

```bash
flutter test
```

## 📚 Dokümantasyon

Detaylı dokümantasyon için [docs/bloc_documentation.md](docs/bloc_documentation.md) dosyasını inceleyebilirsiniz.

## 🤝 Katkıda Bulunma

1. Bu depoyu fork edin
2. Yeni bir branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Değişikliklerinizi commit edin (`git commit -m 'Add some amazing feature'`)
4. Branch'inizi push edin (`git push origin feature/amazing-feature`)
5. Pull Request oluşturun

## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için [LICENSE](LICENSE) dosyasını inceleyebilirsiniz.

## 👥 İletişim

Onur Yaşar - [@onur0481](https://github.com/onur0481)

Proje Linki: [https://github.com/onur0481/bloc_management](https://github.com/onur0481/bloc_management)
