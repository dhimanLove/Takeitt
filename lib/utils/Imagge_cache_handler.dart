import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageCacheManager {
  static final DefaultCacheManager _cacheManager = DefaultCacheManager();

  // Function to cache image
  static Future<void> cacheImage(String url) async {
    await _cacheManager.downloadFile(url);
  }

  // Function to get cached file (optional, if needed)
  static Future<FileInfo?> getCachedImage(String url) async {
    return await _cacheManager.getFileFromCache(url);
  }

  // Function to clear cache (optional, if needed)
  static Future<void> clearCache() async {
    await _cacheManager.emptyCache();
  }
}
