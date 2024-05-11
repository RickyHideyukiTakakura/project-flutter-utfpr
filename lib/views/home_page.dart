import 'package:flutter/material.dart';
import 'package:myapp/services/auth_service.dart';
import 'package:myapp/views/my_reviews_page.dart';
import 'package:myapp/views/search_page.dart';
import 'package:myapp/widgets/home/favorite_movies_section.dart';
import 'package:myapp/widgets/home/greetings.dart';
import 'package:myapp/widgets/home/my_reviews_section.dart';
import 'package:myapp/widgets/home/popular_movies_section.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  late PageController pc;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: currentPage);
  }

  setCurrentPage(page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Use the scaffoldKey for the Scaffold
      appBar: appBarHome(),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 100,
              child: DrawerHeader(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://github.com/rickyhideyukitakakura.png',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text('Ricky'),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                Navigator.pop(context); // close the drawer
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                Navigator.pop(context); // close the drawer
              },
            ),
            const Divider(), // Adiciona uma linha divisória visual opcional
            ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.exit_to_app), // Ícone de logout
              onTap: () {
                context.read<AuthService>().signOut();
              },
            ),
          ],
        ),
      ),
      body: PageView(
        controller: pc,
        onPageChanged: setCurrentPage,
        children: [
          HomeContent(),
          SearchPage(),
          MyReviewsPage(),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  BottomNavigationBar bottomNavigationBar() => BottomNavigationBar(
        backgroundColor: Colors.grey[850]!,
        currentIndex: currentPage,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.reviews),
            label: 'My Reviews',
          ),
        ],
        onTap: (page) {
          pc.animateToPage(
            page,
            duration: const Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        },
      );

  AppBar appBarHome() => AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: const Text(
          "My App",
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              backgroundImage:
                  NetworkImage('https://github.com/rickyhideyukitakakura.png'),
            ),
          ),
        ],
      );
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Greetings(name: 'Ricky'),
          PopularMoviesSection(),
          SizedBox(height: 20),
          FavoriteMoviesSection(),
          MyReviewsSection(),
        ],
      ),
    );
  }
}
