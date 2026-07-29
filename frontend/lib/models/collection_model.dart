class CollectionModel {
  final int id;
  final int tabelaId;
  final String date;
  final String shift;
  final String milkType;
  final double liters;
  final double fatPercent;
  final double snfPercent;
  final double waterPercent;
  final double rate;
  final double totalAmount;
  final String? workerName;

  CollectionModel({
    required this.id,
    required this.tabelaId,
    required this.date,
    required this.shift,
    required this.milkType,
    required this.liters,
    required this.fatPercent,
    required this.snfPercent,
    this.waterPercent = 0.0,
    required this.rate,
    required this.totalAmount,
    this.workerName,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json['id'],
      tabelaId: json['tabela_id'],
      date: json['date'],
      shift: json['shift'],
      milkType: json['milk_type'],
      liters: (json['liters'] as num).toDouble(),
      fatPercent: (json['fat_percent'] as num).toDouble(),
      snfPercent: (json['snf_percent'] as num).toDouble(),
      waterPercent: (json['water_percent'] as num? ?? 0.0).toDouble(),
      rate: (json['rate'] as num).toDouble(),
      totalAmount: (json['total_amount'] as num).toDouble(),
      workerName: json['worker_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tabela_id': tabelaId,
      'date': date,
      'shift': shift,
      'milk_type': milkType,
      'liters': liters,
      'fat_percent': fatPercent,
      'snf_percent': snfPercent,
      'water_percent': waterPercent,
      'rate': rate,
      'total_amount': totalAmount,
      'worker_name': workerName,
    };
  }
}
