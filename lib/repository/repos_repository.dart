import 'package:flutter_sample_app/models/github_repos.dart';

abstract class ReposRepository {
  Future<List<GithubRepo>> fetchRepos(int pageNumber);
}
