import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app/models/github_repos.dart';
import 'package:flutter_sample_app/widget/github_repo/repo_details/github_repo_details_page.dart';

class GithubRepoDetailsPageState extends State<GithubRepoDetailsPage> {
  GithubRepo githubRepo;

  @override
  void initState() {
    super.initState();
    githubRepo = widget.githubRepo;
    print(githubRepo.forksCount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Github repo details"),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            child: _buildTopLayout(),
          ),
        ),
      ),
    );
  }

  Widget _buildTopLayout() {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: new Row(
        children: <Widget>[
          new Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(30.0),
                child: Center(
                  child: Icon(
                    Icons.star_border,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(30.0),
                child: new Text(
                  githubRepo.watchersCount.toString() ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
          new Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(30.0),
                child: Center(
                  child: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(30.0),
                child: new Text(
                  githubRepo.forksCount.toString() ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
