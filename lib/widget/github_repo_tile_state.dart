import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app/models/github_repos.dart';
import 'package:flutter_sample_app/repository/repos_repository.dart';
import 'package:flutter_sample_app/widget/github_repo_tile.dart';

class GithubRepoTileState extends State<GithubReposPage> {
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
  final ScrollController scrollController = new ScrollController();
  final ReposRepository githubReposRepository;
  List<GithubRepos> githubRepos;
  int currentPage;

  GithubRepoTileState(this.githubReposRepository);

  @override
  void initState() {
    super.initState();
    githubRepos = widget.githubReposList;
    currentPage = 1;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: _onScrollNotification,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return _buildRepoRow(githubRepos[index]);
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: githubRepos.length,
        padding: const EdgeInsets.all(16.0),
        controller: scrollController,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              5) {
        githubReposRepository.fetchRepos(currentPage + 1).then((userRepos) {
          currentPage = currentPage + 1;
          setState(() {
            githubRepos.addAll(userRepos);
          });
        });
      }
    }
    return true;
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
