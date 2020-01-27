import 'package:flutter/cupertino.dart';
import 'package:flutter_sample_app/models/github_repos.dart';
import 'package:flutter_sample_app/repository/repos_repository.dart';
import 'package:flutter_sample_app/widget/github_repo/github_repo_tile_state.dart';

class GithubReposPage extends StatefulWidget {
  final List<GithubRepos> githubReposList;
  final ReposRepository githubReposRepository;

  GithubReposPage({Key key, this.githubReposList, this.githubReposRepository}) : super(key: key);

  @override
  State<StatefulWidget> createState() => GithubRepoTileState(githubReposRepository);
}
