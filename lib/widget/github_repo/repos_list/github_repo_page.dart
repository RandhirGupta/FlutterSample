import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app/models/github_repos.dart';
import 'package:flutter_sample_app/repository/repos_repository.dart';
import 'package:flutter_sample_app/widget/github_repo/repos_list/github_repos_page.dart';
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
      appBar: AppBar(
        title: Text('Github repos page'),
      ),
      body: FutureBuilder<List<GithubRepos>>(
        future: githubRepoRepository.fetchRepos(FIRST_PAGE),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? GithubReposPage(
                  githubReposList: snapshot.data,
                  githubReposRepository: githubRepoRepository,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
