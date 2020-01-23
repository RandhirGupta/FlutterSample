import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app/models/github_repos.dart';
import 'package:http/http.dart' as http;
import 'package:isolate/isolate.dart';

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
    final runner = await IsolateRunner.spawn();
    return runner
        .run(_parseUserRepos, client)
        .whenComplete(() => runner.close());
  }

  Future<List<GithubRepos>> _parseUserRepos(http.Client client) async {
    var userRepos =
        await client.get('https:/>/api.github.com/users/RandhirGupta/repos');

    final parsedResponse =
        json.decode(userRepos.body).cast<Map<String, dynamic>>();

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
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          return _buildRepoRow(githubRepos[i]);
        });
  }

  Widget _buildRepoRow(GithubRepos githubRepo) {
    return ListTile(
      title: Text(
        githubRepo.fullName,
        style: _biggerFont,
      ),
    );
  }
}
