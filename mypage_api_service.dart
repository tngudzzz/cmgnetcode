// ignore_for_file: avoid_print
import 'package:dio/dio.dart';
import 'package:newz/config/network/dio_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bookmark_api_model.dart';

class ApiService {
  //
  // Dio 설정
  static var dio = DioManager.instance.dio;

  // accessToken 불러오기 및 토큰 삽입
  static Future<void> _setToken() async {
    // 기기에 저장된 사용자 토큰을 불러와 Api 통신에 필요한 토큰을 headers에 삽입
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("accessToken");
    dio.options.headers = {'x-newz-access-token': accessToken};
  }

  // 리스트 생성 및 초기화
  static Future<List<BookmarkModel>> _setList() async {
    List<BookmarkModel> setlist = [];
    return setlist;
  }

  // 북마크 데이터 GET
  static Future<List<BookmarkModel>> getBookmarkListByDio(String page) async {
    await _setToken();
    List<BookmarkModel> bookmarkInstances = await _setList();
    try {
      Response respBL = await dio.get(
        "/user/bookmark/news",
        queryParameters: {
          'page': page,
          'limit': 5,
        },
      );
      for (var data in respBL.data['news']) {
        bookmarkInstances.add(BookmarkModel.fromJson(data));
      }
      return bookmarkInstances;
    } catch (e) {
      print(e);
    }
    throw Error();
  }

  // 키워드 데이터 GET
  static Future<List> getKeywordListByDio() async {
    await _setToken();
    List<BookmarkModel> keyWordInstances = await _setList();
    try {
      Response respKL = await dio.get("/user/keyword/list");
      for (var data in respKL.data) {
        keyWordInstances.add(data);
      }
      return keyWordInstances;
    } catch (e) {
      print(e);
    }
    throw Error();
  }

  // 북마크 삭제 POST
  static Future<void> removeBookmark(String url) async {
    await _setToken();
    try {
      await dio.post(
        "/user/bookmark/remove",
        data: {
          "newsUrl": url,
        },
      );
    } catch (e) {
      print(e);
    }
  }

  // 북마크 추가 POST
  static void addBookmark(String url) async {
    await _setToken();
    try {
      await dio.post(
        "/user/bookmark/add",
        data: {
          "newsUrl": url,
        },
      );
    } catch (e) {
      print(e);
    }
  }

  // 키워드 삭제 POST
  static void removeKeyword(String keyword) async {
    await _setToken();
    try {
      await dio.post(
        "/user/keyword/remove",
        data: {
          "keywords": [keyword],
        },
      );
    } catch (e) {
      print(e);
    }
  }

  // 키워드 추가 POST
  static Future<void> addKeyword(String keyword) async {
    await _setToken();
    try {
      await dio.post(
        "/user/keyword/add",
        data: {
          "keywords": [keyword],
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
