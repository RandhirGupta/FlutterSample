import 'package:flutter/cupertino.dart';
import 'package:flutter_sample_app/models/github_repos.dart';
import 'package:flutter_sample_app/widget/github_repo/repo_details/github_repo_details_page_state.dart';

class GithubRepoDetailsPage extends StatefulWidget {
  final GithubRepo githubRepo;

  const GithubRepoDetailsPage({Key key, this.githubRepo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => GithubRepoDetailsPageState();
}
