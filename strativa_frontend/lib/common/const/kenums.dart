enum TransactionTypes {
  all,
  food,
  shopping,
  transport,
  transfers,
  other
}

enum VerifyOtpTypes {
  common,
  peekbalance,
}

List<String> get qrTabs => [
  "SCAN QR",
  "GENERATE QR"
];