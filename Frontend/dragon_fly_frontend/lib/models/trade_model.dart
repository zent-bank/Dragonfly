import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class TradeModel {
  double coinAmount;
  double price;

  TradeModel(
    {
      this.coinAmount  = 0.0,
      this.price  = 0.0,
    }
  );
}