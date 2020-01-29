import 'package:flutter/cupertino.dart';
import 'package:flutter_sample_app/models/github_repos.dart';
import 'package:flutter_sample_app/widget/github_repo/repo_details/collapsing_toolbar/collapsing_toolbar_state.dart';

class CollapsingToolbar extends StatefulWidget {
  final GithubRepo githubRepo;

  const CollapsingToolbar({Key key, this.githubRepo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CollapsingToolbarState();
}
