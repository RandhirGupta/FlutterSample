import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app/models/github_repos.dart';

class GithubRepoListTile extends StatelessWidget {
  final GithubRepos githubRepos;
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  const GithubRepoListTile({Key key, this.githubRepos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        githubRepos.name,
        style: _biggerFont,
      ),
      subtitle: Text(githubRepos.description ?? ''),
      dense: true,
    );
  }
}
