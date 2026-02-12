import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/vita_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.notoSerifJp(),
        ),
        backgroundColor: VitaTheme.primaryDark,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [VitaTheme.primaryDark, VitaTheme.primaryLight],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _SettingsTile(
              title: 'Sound Effects',
              subtitle: 'Enable sound effects',
              trailing: Switch(
                value: true,
                onChanged: (value) {},
              ),
            ),
            _SettingsTile(
              title: 'Music',
              subtitle: 'Enable background music',
              trailing: Switch(
                value: true,
                onChanged: (value) {},
              ),
            ),
            _SettingsTile(
              title: 'Vibration',
              subtitle: 'Enable haptic feedback',
              trailing: Switch(
                value: true,
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget trailing;

  const _SettingsTile({
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(
          title,
          style: GoogleFonts.notoSansJp(
            color: VitaTheme.textLight,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.notoSansJp(
            color: VitaTheme.textLight.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
        trailing: trailing,
      ),
    );
  }
}
