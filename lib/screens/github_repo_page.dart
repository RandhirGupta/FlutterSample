import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app/models/github_repos.dart';
import 'package:http/http.dart' as http;

class GithubRepoListPage extends StatelessWidget {
  final http.Client client;
  final String userName;

  GithubRepoListPage({Key key, this.client, this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<GithubRepos>>(
        future: _fetchUserRepos(client, userName),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? GithubRepoList(
                  githubRepos: snapshot.data,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  Future<List<GithubRepos>> _fetchUserRepos(
      http.Client client, String userName) async {
    var userRepos =
        await client.get('https://api.github.com/users/$userName/repos');

    return _parseUserRepos(userRepos.body);
  }

  Future<List<GithubRepos>> _parseUserRepos(String responseBody) async {
    final parsedResponse =
        json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsedResponse
        .map<GithubRepos>((json) => GithubRepos.fromJson(json))
        .toList();
  }
}

class GithubRepoList extends StatelessWidget {
  final List<GithubRepos> githubRepos;
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  GithubRepoList({Key key, this.githubRepos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Repos'),
      ),
      body: _buildGithubRepos(),
    );
  }

  Widget _buildGithubRepos() {
    return ListView.separated(
      itemBuilder: (context, i) {
        return _buildRepoRow(githubRepos[i]);
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: githubRepos.length,
      padding: const EdgeInsets.all(16.0),
    );
  }

  Widget _buildRepoRow(GithubRepos githubRepo) {
    return ListTile(
      title: Text(
        githubRepo.name,
        style: _biggerFont,
      ),
      subtitle: Text(githubRepo.description ?? ''),
      dense: true,
    );
  }
}
