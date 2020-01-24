import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app/screens/user_name_screen.dart';
import 'package:http/http.dart' show get;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Welcome to Flutter',
        theme: ThemeData(primaryColor: Colors.white),
        home: UserNameScreen());
  }
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestion = <WordPair>[];
  final Set<WordPair> _favorites = Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          if (index >= _suggestion.length) {
            _suggestion.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_suggestion[index]);
        });
  }

  Widget _buildRow(WordPair wordPair) {
    final bool isFavorite = _favorites.contains(wordPair);
    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (isFavorite) {
            _favorites.remove(wordPair);
          } else {
            _favorites.add(wordPair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _favorites.map(
        (WordPair wordPair) {
          return ListTile(
            title: Text(
              wordPair.asPascalCase,
              style: _biggerFont,
            ),
          );
        },
      );

      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
        appBar: AppBar(
          title: Text('Favorite Suggestions'),
        ),
        body: ListView(children: divided),
      );
    }));
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RandomWordsState();
}
