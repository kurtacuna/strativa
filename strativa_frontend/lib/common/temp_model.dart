Map<String, dynamic> get userData => {
  "user_id": "userid",
  "first_name": "First Name",
  "last_name": "Last Name",
  
  "balance": "1231.00",
  "strativa_card_number": "1234 5678 9101 1121",
  "strativa_card_expiry": "02/27",
  "recent_transaction_date": "2025-03-28 18:16:30.123456+00:00",
  "online_card_details": {
    "online_card_number": "1234 5678 1234 5678",
  },

};

List<Map<String, dynamic>> get transactions => [
  {
    "id": "1",
    "category": "shopping",
    "store": "Alfamart Grocery Store",
    "amount": "200.00",
    "datetime": "2025-03-28 18:16:30.123456+00:00",
    "resulting_balance": "1231.10"
  },
  {
    "id": "2",
    "category": "shopping",
    "store": "Alfamart Grocery Store",
    "amount": "200.00",
    "datetime": "2025-03-28 18:16:30.123456+00:00",
    "resulting_balance": "1231.00"
  },
  {
    "id": "3",
    "category": "shopping",
    "store": "Alfamart Grocery Store",
    "amount": "200.00",
    "datetime": "2025-03-28 18:16:30.123456+00:00",
    "resulting_balance": "1231.00"
  },
  {
    "id": "4",
    "category": "shopping",
    "store": "Alfamart Grocery Store",
    "amount": "200.00",
    "datetime": "2025-03-28 18:16:30.123456+00:00",
    "resulting_balance": "1231.00"
  },
  {
    "id": "5",
    "category": "shopping",
    "store": "Alfamart Grocery Store",
    "amount": "200.00",
    "datetime": "2025-03-28 18:16:30.123456+00:00",
    "resulting_balance": "1231.00"
  },
  {
    "id": "6",
    "category": "food",
    "store": "Alfamart Grocery Store",
    "amount": "225.00",
    "datetime": "2025-03-28 18:16:30.123456+00:00",
    "resulting_balance": "1400.00"
  },
  {
    "id": "7",
    "category": "transport",
    "store": "Alfamart Grocery Store",
    "amount": "225.00",
    "datetime": "2025-03-28 18:16:30.123456+00:00",
    "resulting_balance": "1400.00"
  },
  {
    "id": "8",
    "category": "shopping",
    "store": "Alfamart Grocery Store",
    "amount": "225.00",
    "datetime": "2025-03-28 18:16:30.123456+00:00",
    "resulting_balance": "1400.00"
  },
  {
    "id": "9",
    "category": "shopping",
    "store": "Alfamart Grocery Store",
    "amount": "225.00",
    "datetime": "2025-03-28 18:16:30.123456+00:00",
    "resulting_balance": "1400.00"
  },
];


// TODO: clarify details
List<Map<String, dynamic>> get otherAccounts => [
  {
    "id": "1",
    "name": "Full Name",
    "type": "Savings Account",
    "number": "0987 654 3210",
    "balance": "2678.00",
  },
  {
    "id": "2",
    "name": "Full Name",
    "type": "Savings Account",
    "number": "0987 654 3210",
    "balance": "2678.00",
  },
];

