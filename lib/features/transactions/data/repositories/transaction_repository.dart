import 'package:bloc_management/core/base/base_repository.dart';
import 'package:bloc_management/features/transactions/data/models/transaction_model.dart';

class TransactionRepository implements BaseRepository<TransactionModel> {
  final List<TransactionModel> _transactions = [];

  @override
  Future<List<TransactionModel>> getAll() async {
    // TODO: Gerçek API çağrısı yapılacak
    await Future.delayed(const Duration(seconds: 1));
    return _transactions;
  }

  @override
  Future<TransactionModel?> getById(int id) async {
    // TODO: Gerçek API çağrısı yapılacak
    await Future.delayed(const Duration(milliseconds: 500));
    return _transactions.firstWhere((t) => t.id == id);
  }

  @override
  Future<void> create(TransactionModel item) async {
    // TODO: Gerçek API çağrısı yapılacak
    await Future.delayed(const Duration(milliseconds: 500));
    _transactions.add(item);
  }

  @override
  Future<void> update(TransactionModel item) async {
    // TODO: Gerçek API çağrısı yapılacak
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _transactions.indexWhere((t) => t.id == item.id);
    if (index != -1) {
      _transactions[index] = item;
    }
  }

  @override
  Future<void> delete(int id) async {
    // TODO: Gerçek API çağrısı yapılacak
    await Future.delayed(const Duration(milliseconds: 500));
    _transactions.removeWhere((t) => t.id == id);
  }

  Future<List<TransactionModel>> getTransactions(int cardId) async {
    // TODO: Gerçek API çağrısı yapılacak
    await Future.delayed(const Duration(seconds: 1));

    // Örnek veri oluştur
    final dummyTransactions = List.generate(
      20,
      (index) => TransactionModel(
        id: index,
        cardId: cardId == 0 ? (index % 3) + 1 : cardId, // cardId 0 ise 1-3 arası kartlara dağıt
        title: index % 2 == 0 ? 'Gelir ${index + 1}' : 'Gider ${index + 1}',
        amount: (index + 1) * 100.0,
        date: DateTime.now().subtract(Duration(days: index)),
        type: index % 2 == 0 ? 'income' : 'expense',
        description: 'İşlem açıklaması ${index + 1}',
        category: index % 2 == 0 ? 'Maaş' : 'Market',
      ),
    );

    // cardId 0 ise tüm işlemleri, değilse sadece o karta ait işlemleri döndür
    return dummyTransactions.where((t) => cardId == 0 || t.cardId == cardId).toList();
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    // TODO: Gerçek API çağrısı yapılacak
    await Future.delayed(const Duration(seconds: 1));
    _transactions.add(transaction);
  }

  Future<void> deleteTransaction(int id) async {
    // TODO: Gerçek API çağrısı yapılacak
    await Future.delayed(const Duration(seconds: 1));
    _transactions.removeWhere((t) => t.id == id);
  }
}
