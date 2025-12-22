import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'tabs/home_tab.dart';
import 'screens/categories_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/profile_page.dart';
import 'screens/order_history_screen.dart';
import 'screens/search_screen.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String? _profilePictureUrl;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeTab(),
    const CategoriesScreen(),
    const CartScreen(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _fetchUserProfilePicture();
  }

  Future<void> _fetchUserProfilePicture() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (docSnapshot.exists && mounted) {
        setState(() {
          _profilePictureUrl = docSnapshot.data()?['profilePictureUrl'];
        });
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Default profile avatar
    Widget profileIcon = CircleAvatar(
      radius: 12,
      backgroundColor: Colors.grey[300],
      child: const Icon(Icons.person_outline, size: 18, color: Colors.white),
    );

    // If user has profile picture
    if (_profilePictureUrl != null && _profilePictureUrl!.isNotEmpty) {
      profileIcon = CircleAvatar(
        radius: 12,
        backgroundImage: NetworkImage(_profilePictureUrl!),
      );
    }

    // Active icon when selected
    Widget activeProfileIcon = CircleAvatar(
      radius: 14,
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: CircleAvatar(
        radius: 12,
        backgroundColor: Colors.grey[300],
        backgroundImage:
            (_profilePictureUrl != null && _profilePictureUrl!.isNotEmpty)
                ? NetworkImage(_profilePictureUrl!)
                : null,
        child: (_profilePictureUrl == null || _profilePictureUrl!.isEmpty)
            ? const Icon(Icons.person, size: 18, color: Colors.white)
            : null,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('lib/assets/images/logo-bgremoved.png', height: 40),
        actions: [
          // 🔍 SEARCH BUTTON 
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SearchScreen(),
                ),
              );
            },
          ),

          // 👜 ORDER HISTORY
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const OrderHistoryScreen(),
                ),
              );
            },
            icon: const Icon(Icons.shopping_bag_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_outlined),
              activeIcon: Icon(Icons.grid_view_sharp),
              label: 'Categories'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              activeIcon: Icon(Icons.shopping_cart),
              label: 'Cart'),
          BottomNavigationBarItem(
            icon: profileIcon,
            activeIcon: activeProfileIcon,
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: const Color(0xFF7B3F00).withOpacity(0.6),
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
