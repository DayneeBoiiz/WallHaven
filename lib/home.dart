import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallhaven/auth/auth.dart';
import 'package:wallhaven/favorites.dart';
import 'databse/wallpaper_category.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ImageData {
  final String imageUrl;
  bool isFavorite;

  ImageData({required this.imageUrl, this.isFavorite = false});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // ignore: unused_field
  late TabController _controller;
  final User? user = Auth().currentUser;
  final List<ImageData> imageUrls = [
    ImageData(
      imageUrl:
          'https://images.unsplash.com/photo-1687161590608-6d948d357bad?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=653&q=80',
    ),
    ImageData(
      imageUrl:
          'https://plus.unsplash.com/premium_photo-1674671748477-5354897d35c3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
    ),
    ImageData(
      imageUrl:
          'https://images.unsplash.com/photo-1687125106218-3c7a1963bd6e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=734&q=80',
    ),
    ImageData(
      imageUrl:
          'https://images.unsplash.com/photo-1687298668922-b4dd3653877d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
    ),
    ImageData(
      imageUrl:
          'https://images.unsplash.com/photo-1687218209500-be09358e0072?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
    ),
    ImageData(
      imageUrl:
          'https://images.unsplash.com/photo-1687220296822-5ae701b3b360?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
    ),
    ImageData(
      imageUrl:
          'https://images.unsplash.com/photo-1687223913109-68a09fdcd8bf?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80',
    ),
    ImageData(
      imageUrl:
          'https://images.unsplash.com/photo-1687184688387-bdacfcf7c9f5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
    ),
    ImageData(
        imageUrl:
            'https://images.unsplash.com/photo-1687222771254-ddaa3381e619?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80'),
  ];

  int currrentIndex = 0;
  late int tabBarViewIndex;
  bool isBottomNavigationBarVisible = true;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  // void _onTabChanged(int index) {
  //   setState(() {
  //     currrentIndex = index; // Update currentIndex
  //     tabBarViewIndex = index; // Update tabBarViewIndex
  //     _controller.animateTo(index); // Update TabController's index
  //     isBottomNavigationBarVisible =
  //         index == 0; // Show/hide the bottom navigation bar
  //   });
  // }

  Widget _title() {
    return const Text(
      "HD Wallpaper",
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _userUid() {
    return Text(user?.email ?? 'user email');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign Out'),
    );
  }

  // void _handleTabChange() {
  //   setState(() {
  //     tabBarViewIndex = _controller.index;
  //   });
  // }

  TabBar get _tabBar => TabBar(
        controller: _controller,
        labelColor: Colors.white,
        indicatorColor: Colors.white,
        labelStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
        labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        unselectedLabelColor: Colors.grey,
        tabs: const [
          Tab(
            child: Text('HOME'),
          ),
          Tab(
            child: Text('CATEGORIES'),
          ),
        ],
      );

  void _onTabChanged(int index) {
    setState(() {
      currrentIndex = index;
    });
  }

  Widget _buildContext(BuildContext context) {
    if (currrentIndex == 0) {
      return Stack(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20.0, left: 5.0),
            child: Text(
              'Featured',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 55.0),
            child: SizedBox(
              height: 120.0,
              child: WallpaperCategoryList(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 190.0, left: 5.0),
            child: Text(
              'Top Wallpapers',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 194.0, left: 320.0),
            child: SizedBox(
              height: 20.0,
              width: 80.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 223, 31, 89),
                ),
                onPressed: () {
                  // Implement login functionality here
                  // registerWithEmailAndPassword();
                },
                child: const Text(
                  'See More',
                  style: TextStyle(
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                    fontSize: 7.0,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 240.0),
            child: MasonryGridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8.0),
              itemCount: imageUrls.length,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                final random = Random();
                final height = random.nextInt(100) + 100;
                final imageData = imageUrls[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenImagePage(
                            imageData: imageData,
                          ),
                        ));
                  },
                  child: ClipRRect(
                      child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      height: height.toDouble(),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(imageData.imageUrl),
                            fit: BoxFit.cover,
                          )),
                    ),
                  )),
                );
              },
            ),
          ),
        ],
      );
    } else if (currrentIndex == 1) {
      return const FavoritesPage();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      // initialIndex: tabBarViewIndex,
      child: Scaffold(
          backgroundColor: const Color(0x000201c1),
          appBar: AppBar(
            title: _title(),
            centerTitle: true,
            backgroundColor: const Color(0x000201c1),
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              // ignore: prefer_const_constructors
              child: _tabBar,
            ),
          ),
          body: TabBarView(
            controller: _controller,
            children: [
              Builder(builder: (BuildContext context) {
                return _buildContext(context);
              }),
              Container(
                color: Colors.amber,
              )
            ],
          ),
          bottomNavigationBar: tabBarViewIndex == 0
              ? BottomNavigationBar(
                  currentIndex: currrentIndex,
                  onTap: _onTabChanged,
                  selectedItemColor: const Color.fromARGB(255, 223, 31, 89),
                  unselectedItemColor: Colors.white,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                      backgroundColor: Colors.transparent,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite),
                      label: 'Favorites',
                      backgroundColor: Colors.transparent,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: 'Search',
                      backgroundColor: Colors.transparent,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profile',
                      backgroundColor: Colors.transparent,
                    ),
                  ],
                )
              : null),
    );
  }
}

class FullScreenImagePage extends StatefulWidget {
  final ImageData imageData;

  const FullScreenImagePage({super.key, required this.imageData});

  @override
  State<FullScreenImagePage> createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  bool isFavorite = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<String> _favoriteImageUrls = [];

  @override
  void initState() {
    super.initState();

    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteKey = 'favoriteImageUrls';
    final dynamic favoriteImageUrls = prefs.getStringList(favoriteKey);

    if (favoriteImageUrls != null) {
      final List<String> favoriteUrls = favoriteImageUrls.cast<String>();

      setState(() {
        _favoriteImageUrls = favoriteUrls;
        widget.imageData.isFavorite =
            _favoriteImageUrls.contains(widget.imageData.imageUrl);
      });
    }
  }

  // Future<void> initializePreferences() async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final favoriteKey = 'isFavorite';

  //     final savedFavorite = prefs.getBool(favoriteKey) ?? false;

  //     setState(() {
  //       isFavorite = savedFavorite;
  //     });
  //   } catch (e) {
  //     print('Error initializing shared preferences: $e');
  //     // Handle the error appropriately (e.g., show an error message)
  //   }
  // }

  Future<void> toggleFavorite() async {
    final prefs = await _prefs;
    const favoriteKey = 'favoriteImageUrls';
    final List<String> favoriteImageUrls = _favoriteImageUrls;

    setState(() {
      widget.imageData.isFavorite = !widget.imageData.isFavorite;
    });

    if (widget.imageData.isFavorite) {
      // Add the image URL to favorites
      favoriteImageUrls.add(widget.imageData.imageUrl);
    } else {
      // Remove the image URL from favorites
      favoriteImageUrls.remove(widget.imageData.imageUrl);
    }

    // Save the updated favorites list to local storage
    await prefs.setStringList(favoriteKey, favoriteImageUrls);
  }

  // Future<void> downloadImage() async {
  //   try {
  //     final response = await http.get(Uri.parse(widget.imageUrl));
  //     final directory = await getExternalStorageDirectory();
  //     final savedDir = directory!.path;
  //     final file = File('$savedDir/image.jpg');
  //     await file.writeAsBytes(response.bodyBytes);
  //     print('Image downloaded successfully.');
  //   } catch (error) {
  //     print('Error downloading image: $error');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.imageData.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 70,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      toggleFavorite();
                      // Handle favorite button logic
                    },
                    icon: Icon(
                      widget.imageData.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: widget.imageData.isFavorite
                          ? const Color.fromARGB(255, 223, 31, 89)
                          : Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      // await downloadImage();
                    },
                    icon: const Icon(
                      Icons.download,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Handle set as wallpaper button logic
                    },
                    icon: const Icon(
                      Icons.wallpaper,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
