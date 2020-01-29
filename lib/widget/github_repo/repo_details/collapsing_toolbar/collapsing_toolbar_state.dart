import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app/models/github_repos.dart';
import 'package:flutter_sample_app/widget/github_repo/repo_details/collapsing_toolbar/app_bar_delegate.dart';
import 'package:flutter_sample_app/widget/github_repo/repo_details/collapsing_toolbar/collapsing_toolbar.dart';
import 'package:flutter_sample_app/widget/github_repo/repo_details/github_repo_details_page.dart';

class CollapsingToolbarState extends State<CollapsingToolbar> {
  GithubRepo githubRepo;

  @override
  void initState() {
    super.initState();
    githubRepo = widget.githubRepo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool scrollInnerBox) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    githubRepo.name,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 17.0,
                    ),
                  ),
                  background: Image.network(
                    githubRepo.owner.avatarUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: AppBarDelegate(
                  TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: <Widget>[
                      Tab(
                        text: "Repo Details",
                      ),
                      Tab(
                        text: "Tab 2",
                      ),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: Center(
            child: TabBarView(
              children: <Widget>[
                Scaffold(
                  body: GithubRepoDetailsPage(
                    githubRepo: githubRepo,
                  ),
                ),
                Scaffold(
                  body: Text(
                    "Hello I am second !",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
