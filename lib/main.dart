import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spotify_sdk/spotify_sdk.dart';

void main() {
  runApp(SpotifyCloneApp());
}

class SpotifyCloneApp extends StatelessWidget {
  const SpotifyCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String? _accessToken;
  List<dynamic> _tracks = [];

  final List<Widget> _widgetOptions = [
    MusicScreen(),
    LibraryScreen(),
    SearchScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _connectToSpotify() async {
    try {
      var token = await SpotifySdk.getAccessToken(
        clientId: "9ca1b527737a4808918af9f6b660a2c3",
        redirectUrl: "http://localhost:3000/callback",
        scope:
            "user-read-private user-read-email user-read-playback-state user-modify-playback-state streaming",
      );
      setState(() {
        _accessToken = token;
      });
      _fetchTracks();
    } catch (e) {
      print("Error connecting to Spotify: $e");
    }
  }

  Future<void> _fetchTracks() async {
    if (_accessToken == null) return;
    final response = await http.get(
      Uri.parse(
        "https://api.spotify.com/v1/playlists/https://open.spotify.com/playlist/0WUOg6Sy7sAGKzLdOUikSy?si=pPIwf7zaQHq6LTQKvH1xBA/tracks",
      ),
      headers: {"Authorization": "Bearer $_accessToken"},
    );
    if (response.statusCode == 200) {
      setState(() {
        _tracks = json.decode(response.body)["items"];
      });
    } else {
      print("Error fetching tracks: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spotify Clone"),
        actions: [
          IconButton(icon: Icon(Icons.login), onPressed: _connectToSpotify),
        ],
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Library',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}

class MusicScreen extends StatelessWidget {
  const MusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Music Screen"));
  }
}

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Library Screen"));
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Search Screen"));
  }
}
