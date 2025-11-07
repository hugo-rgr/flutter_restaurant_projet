import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/domain/user_logic.dart';
import 'package:flutter_restaurant_app/presentation/common/widgets/ore_button.dart';
import 'package:flutter_restaurant_app/presentation/profile/state/profile_notifier.dart';
import 'package:flutter_restaurant_app/presentation/profile/state/profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/models/user.dart';
import '../common/base_page.dart';

class Profile extends BasePage<ProfileNotifier, ProfileState> {
  Profile({super.key}) : super(provider: profileNotifierProvider);

  static const route = '/profile';

  @override
  Widget buildContent(BuildContext context, WidgetRef ref, ProfileState state) {
    final user = ref.watch(userProvider);

    return user == null
        ? Center(
          child: OreButton(
            onTap: () {
              ref.read(notifier).openAuth();
            },
            text: "M'authentifier",
          ),
        )
        : SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 32),
              CircleAvatar(
                radius: 50,
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  _getInitials(
                    user.name != '' && user.name != null
                        ? user.name!
                        : user.email,
                  ),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: Column(
                    children: [
                      _buildInfoTile(
                        icon: Icons.person,
                        label: 'Nom',
                        value: user.name ?? 'Non renseigné',
                      ),
                      const Divider(height: 1),
                      _buildInfoTile(
                        icon: Icons.email,
                        label: 'Email',
                        value: user.email,
                      ),
                      const Divider(height: 1),
                      _buildInfoTile(
                        icon: Icons.phone,
                        label: 'Téléphone',
                        value: user.phone ?? 'Non renseigné',
                      ),
                      const Divider(height: 1),
                      _buildInfoTile(
                        icon: Icons.badge,
                        label: 'Rôle',
                        value: _getRoleLabel(user.role),
                      ),
                    ],
                  ),
                ),
              ),

              OreButton(
                onTap: () {
                  ref.read(notifier).logout();
                },
                widget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      "Se déconnecter",

                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        label,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  String _getInitials(String text) {
    final words = text.trim().split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return text.substring(0, 2).toUpperCase();
  }

  String _getRoleLabel(UserRole role) {
    // Adapte selon ton enum UserRole
    return role.toString().split('.').last;
  }

  @override
  AppBar? buildAppBar(
    BuildContext context,
    WidgetRef ref,
    ProfileState? state,
  ) {
    return AppBar(
      backgroundColor: Colors.orange,
      title: Text(
        'PROFILE',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      centerTitle: false,
    );
  }

  @override
  Color? buildBackgroundColor(WidgetRef ref, ProfileState? state) {
    return Colors.white;
  }
}
