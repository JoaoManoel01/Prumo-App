import 'package:flutter/material.dart';

import '../components/app_bottom_nav.dart';
import 'catalog_screen.dart';
import 'clients_screen.dart';
import 'quote_list_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [QuoteListScreen(), CatalogScreen(), ClientsScreen()],
      ),
      bottomNavigationBar: AppBottomNav(
        selectedIndex: _index,
        onSelected: (index) => setState(() => _index = index),
      ),
    );
  }
}
