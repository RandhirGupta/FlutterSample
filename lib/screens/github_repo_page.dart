import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app/models/github_repos.dart';
import 'package:flutter_sample_app/repository/repos_repository.dart';
import 'package:http/http.dart' as http;

const int FIRST_PAGE = 1;

class GithubRepoListPage extends StatelessWidget {
  final http.Client client;
  final String userName;

  final ReposRepository githubRepoRepository;

  GithubRepoListPage(
      {Key key, this.client, this.userName, this.githubRepoRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<GithubRepos>>(
        future: githubRepoRepository.fetchRepos(FIRST_PAGE),
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
}

class GithubRepoList extends StatelessWidget {
  final List<GithubRepos> githubRepos;
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
  final int currentPage;
  final ReposRepository githubReposRepository;

  GithubRepoList(
      {Key key, this.githubRepos, this.currentPage, this.githubReposRepository})
      : super(key: key);

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
