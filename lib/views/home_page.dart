import 'package:flutter/material.dart';
import 'package:myapp/views/my_reviews_page.dart';
import 'package:myapp/widgets/home/favorite_movies_section.dart';
import 'package:myapp/widgets/home/greetings.dart';
import 'package:myapp/widgets/home/my_reviews_section.dart';
import 'package:myapp/widgets/home/popular_movies_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  late PageController pc;

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
      appBar: appBarHome(),
      body: PageView(
        controller: pc,
        onPageChanged: setCurrentPage,
        children: const [
          HomeContent(),
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
          onPressed: () => {},
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
