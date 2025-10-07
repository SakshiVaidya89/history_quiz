import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onLogout;
  final VoidCallback? onDashboard;
  
  const CustomAppBar({
    super.key,
    required this.title,
    this.onLogout,
    this.onDashboard,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF8D6E63),
      elevation: 4,
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Merriweather',
          color: Colors.white,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: [
        PopupMenuButton<String>(
          offset: const Offset(0, 45),
          icon: const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              color: Color(0xFF8D6E63),
            ),
          ),
          onSelected: (value) {
            if (value == 'dashboard') {
              if (onDashboard != null) {
                onDashboard!();
              } else {
                Navigator.pushNamed(context, '/welcome');
              }
            } else if (value == 'logout') {
              if (onLogout != null) {
                onLogout!();
              } else {
                Navigator.pushReplacementNamed(context, '/');
              }
            }
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem<String>(
              value: 'dashboard',
              child: Row(
                children: [
                  Icon(Icons.dashboard, color: Color(0xFF5D4037)),
                  SizedBox(width: 8),
                  Text('Dashboard'),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'logout',
              child: Row(
                children: [
                  Icon(Icons.logout, color: Color(0xFF5D4037)),
                  SizedBox(width: 8),
                  Text('Logout'),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
