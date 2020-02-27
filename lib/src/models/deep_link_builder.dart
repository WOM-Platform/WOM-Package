import 'package:wom_package/src/utils/config.dart';

class DeepLinkBuilder {
  final String otc;
  final TransactionType type;
//  final String baseUrl;

  DeepLinkBuilder(this.otc, this.type);

  String build() {
    return "${Config.deepBaseUrl}${type.toString().toLowerCase().replaceAll("transactiontype.", "")}/$otc";
  }
}

enum TransactionType {
  VOUCHERS,
  PAYMENT,
}

//          final link = "https://wom.social/vouchers/c7aafccc5e55431082b9c2ebaeba32cd";
////            final link =
////                "https://wom.social/payment/de8eac804f9a477bbf3ba0e111139f2a";
