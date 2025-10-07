import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.currentUser;
    
    return Drawer(
      child: Container(
        color: const Color(0xFFF8F1E3),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF8D6E63),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (user != null)
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Text(
                        user.name.substring(0, 1).toUpperCase(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8D6E63),
                        ),
                      ),
                    )
                  else
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Color(0xFF8D6E63),
                      ),
                    ),
                  const SizedBox(height: 10),
                  Text(
                    user != null ? user.name : 'History Quiz',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Merriweather',
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    user != null ? user.email : 'Test your knowledge',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                      fontFamily: 'Merriweather',
                    ),
                  ),
                ],
              ),
            ),
            if (user != null)
              _buildDrawerItem(
                context,
                icon: Icons.dashboard,
                title: 'Dashboard',
                onTap: () => Navigator.pushReplacementNamed(context, '/dashboard'),
              ),
            _buildDrawerItem(
              context,
              icon: Icons.home,
              title: 'Home',
              onTap: () => Navigator.pushReplacementNamed(context, '/welcome'),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.history_edu,
              title: 'Select Era',
              onTap: () => Navigator.pushNamed(context, '/era_selection'),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.quiz,
              title: 'Take Quiz',
              onTap: () => Navigator.pushNamed(context, '/quiz'),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.leaderboard,
              title: 'Results',
              onTap: () => Navigator.pushNamed(context, '/results'),
            ),
            const Divider(color: Color(0xFF8D6E63)),
            _buildDrawerItem(
              context,
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {},
            ),
            _buildDrawerItem(
              context,
              icon: Icons.help,
              title: 'Help & FAQ',
              onTap: () {},
            ),
            if (user != null)
              _buildDrawerItem(
                context,
                icon: Icons.logout,
                title: 'Logout',
                onTap: () {
                  Provider.of<UserProvider>(context, listen: false).clearUser();
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF5D4037)),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF5D4037),
          fontFamily: 'Merriweather',
        ),
      ),
      onTap: onTap,
    );
  }
}
