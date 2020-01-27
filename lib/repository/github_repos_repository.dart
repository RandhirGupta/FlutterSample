import 'dart:convert';

import 'package:flutter_sample_app/models/github_repos.dart';
import 'package:flutter_sample_app/repository/repos_repository.dart';
import 'package:http/http.dart' as http;

const GITHUB_BASE_URL = "https://api.github.com";

class GithubReposRepository implements ReposRepository {
  final String userName;
  final int perPageLimit;

  GithubReposRepository({this.userName, this.perPageLimit});

  @override
  Future<List<GithubRepo>> fetchRepos(int pageNumber) async {
    http.Response githubRepoResponse = await http.get(GITHUB_BASE_URL +
        "/users/$userName/repos?page=$pageNumber&per_page=$perPageLimit");
    return _parseUserRepos(githubRepoResponse.body);
  }

  Future<List<GithubRepo>> _parseUserRepos(String responseBody) async {
    final parsedResponse =
        json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsedResponse
        .map<GithubRepo>((json) => GithubRepo.fromJson(json))
        .toList();
  }
}
