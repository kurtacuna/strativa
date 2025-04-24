enum TransactionTypes {
  all,
  food,
  shopping,
  bills,
  transport,
  transfers,
  other
}

enum VerifyOtpTypes {
  common,
  peekbalance,
}

enum AppTransferReceiveWidgetTypes {
  myaccounts,
  otheraccounts,
}

List<String> get qrTabs => [
  "SCAN QR",
  "GENERATE QR"
];