import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: const [
              ProfileSection(),
              SizedBox(height: 12),
              SecuritySection(),
              SizedBox(height: 12),
              NotificationsSection(),
              SizedBox(height: 12),
              TransactionsSection(),
              SizedBox(height: 12),
              HelpCenterSection(),
              SizedBox(height: 20),
              SignOutButton(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: "My Accounts"),
          BottomNavigationBarItem(icon: Icon(Icons.send), label: "Transfer"),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: "PayLoad"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Invest"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return sectionCard(
      title: "Profile",
      children: [
        settingTile("Change Password", onTap: () {}),
        settingTile("Update Mobile Number", onTap: () {}),
      ],
    );
  }
}

class SecuritySection extends StatefulWidget {
  const SecuritySection({super.key});

  @override
  State<SecuritySection> createState() => _SecuritySectionState();
}

class _SecuritySectionState extends State<SecuritySection> {
  bool mobileKey = false;

  @override
  Widget build(BuildContext context) {
    return sectionCard(
      title: "Security",
      children: [
        buildCustomSwitchTile(
          title: "Mobile Key",
          value: mobileKey,
          onChanged: (val) => setState(() => mobileKey = val),
        ),
        settingTile("Access Management", onTap: () {}),
        settingTile("Peek Quick Balance Viewing", onTap: () {}),
        settingTile("User-Defined Transaction Limits", onTap: () {}),
      ],
    );
  }

  // 🔧 Reusable clean switch
  Widget buildCustomSwitchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
      ),
      child: SwitchListTile(
        title: Text(title),
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white, // Thumb ON
        activeTrackColor: const Color(0xFFFF5E00), // Orange track ON
        inactiveThumbColor: const Color.fromARGB(255, 0, 0, 0),
        inactiveTrackColor: const Color.fromARGB(255, 255, 255, 255),
        dense: true,
      ),
    );
  }
}


class NotificationsSection extends StatefulWidget {
  const NotificationsSection({super.key});

  @override
  State<NotificationsSection> createState() => _NotificationsSectionState();
}

class _NotificationsSectionState extends State<NotificationsSection> {
  bool transactionAlerts = true;
  bool promotions = true;
  bool maintenanceAlerts = true;
  bool smsNotifications = false;

  @override
  Widget build(BuildContext context) {
    return sectionCard(
      title: "Notifications & Alerts",
      children: [
        buildCustomSwitchTile(
          title: "Transaction alerts",
          value: transactionAlerts,
          onChanged: (val) => setState(() => transactionAlerts = val),
        ),
        buildCustomSwitchTile(
          title: "Promotions",
          value: promotions,
          onChanged: (val) => setState(() => promotions = val),
        ),
        buildCustomSwitchTile(
          title: "Maintenance Alerts",
          value: maintenanceAlerts,
          onChanged: (val) => setState(() => maintenanceAlerts = val),
        ),
        buildCustomSwitchTile(
          title: "SMS Notifications",
          value: smsNotifications,
          onChanged: (val) => setState(() => smsNotifications = val),
        ),
      ],
    );
  }

  // 🔧 This helper creates a uniform switch style with no ripple/outline
  Widget buildCustomSwitchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
      ),
      child: SwitchListTile(
        title: Text(title),
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white, // White thumb when ON
        activeTrackColor: const Color(0xFFFF5E00), // Orange track when ON
        inactiveThumbColor: const Color.fromARGB(255, 0, 0, 0),           // Thumb when OFF
        inactiveTrackColor: const Color.fromARGB(255, 255, 255, 255),      // Track when OFF
        dense: true, // Slightly tighter layout
      ),
    );
  }
}


class TransactionsSection extends StatelessWidget {
  const TransactionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return sectionCard(
      title: "Transactions",
      children: [
        settingTile("Connect a mobile number or email address", onTap: () {}),
        settingTile("QR generator", onTap: () {}),
      ],
    );
  }
}

class HelpCenterSection extends StatelessWidget {
  const HelpCenterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return sectionCard(
      title: "Help Center",
      children: [
        settingTile("FAQs Support", onTap: () {}),
      ],
    );
  }
}

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text("Sign Out", style: TextStyle(color: Colors.white)),
    );
  }
}

Widget sectionCard({required String title, required List<Widget> children}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 2,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF00796B), // medium teal
                Color(0xFF26A69A), // light teal
                Color(0xFF26A69A), // light teal
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        ...children,
      ],
    ),
  );
}


Widget settingTile(String title, {VoidCallback? onTap}) {
  return ListTile(
    title: Text(title),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    onTap: onTap,
  );
}

Widget switchTile(String title, bool value, {required ValueChanged<bool> onChanged}) {
  return SwitchListTile(
    title: Text(title),
    value: value,
    onChanged: onChanged,
  );
}
