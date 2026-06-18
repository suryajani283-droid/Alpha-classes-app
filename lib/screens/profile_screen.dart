import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final profile = context.watch<AuthProvider>().profile;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          CircleAvatar(radius: 40, backgroundImage: profile?.photoUrl != null ? NetworkImage(profile!.photoUrl!) : null),
          const SizedBox(height: 12),
          Text(profile?.name ?? 'User', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text('Class: ${profile?.userClass ?? 'N/A'}'),
          const Divider(),
          ListTile(leading: const Icon(Icons.school), title: const Text('My Courses'), onTap: () {}),
          ListTile(leading: const Icon(Icons.download), title: const Text('Downloads'), onTap: () {}),
          ListTile(leading: const Icon(Icons.payment), title: const Text('Payments'), onTap: () {}),
          ListTile(leading: const Icon(Icons.settings), title: const Text('Settings'), onTap: () {}),
          ListTile(leading: const Icon(Icons.help), title: const Text('Help Center'), onTap: () {}),
          ListTile(leading: const Icon(Icons.logout), title: const Text('Logout'), onTap: () {
            context.read<AuthProvider>().logout();
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          }),
        ]),
      ),
    );
  }
}
