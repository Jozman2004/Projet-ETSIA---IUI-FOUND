import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Notifications',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          titleSpacing: 0,
          bottom: const TabBar(
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.orange,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: 'Evènements'),
              Tab(text: 'Messages (3)'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildNotificationsList(),
            const Center(child: Text('Les messages apparaîtront ici.')),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Action pour le bouton +
          },
          backgroundColor: Colors.white,
          shape: const CircleBorder(
            side: BorderSide(color: Colors.orange, width: 2.0),
          ),
          child: const Icon(Icons.add, color: Colors.orange, size: 32),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    icon: const Icon(Icons.grid_view_outlined,
                        color: Colors.grey),
                    onPressed: () {}),
                IconButton(
                    icon: const Icon(Icons.menu, color: Colors.grey),
                    onPressed: () {}),
                const SizedBox(width: 48), // Espace pour le bouton flottant
                IconButton(
                    icon:
                    const Icon(Icons.notifications, color: Colors.orange),
                    onPressed: () {
                      // Déjà sur la page, ne rien faire
                    }),
                IconButton(
                    icon: const Icon(Icons.person_outline, color: Colors.grey),
                    onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListView _buildNotificationsList() {
    return ListView(
      padding: const EdgeInsets.only(top: 20),
      children: [
        _buildNotificationItem(
          name: 'Karell Jodom',
          action: ' a commenté votre publication.',
          time: 'il y a 20 min',
        ),
        _buildNotificationItem(
          name: 'Jozmano',
          action: ' a commenté votre publication.',
          time: 'il y a 10 min',
        ),
        _buildNotificationItem(
          name: 'Michelle Kamga',
          action: ' vous a envoyé un message.',
          time: 'il y a 2h',
        ),
      ],
    );
  }

  Widget _buildNotificationItem({
    required String name,
    required String action,
    required String time,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundColor: Color(0xFFD9E0E6),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 15, color: Colors.black),
                    children: [
                      TextSpan(
                        text: name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: action),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFD9E0E6),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}