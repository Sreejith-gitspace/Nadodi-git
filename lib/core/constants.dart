import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? 'https://api.nadodi.app';
  static String get openAiApiKey => dotenv.env['OPENAI_API_KEY'] ?? '';
  static String get cloudinaryUploadPreset => dotenv.env['CLOUDINARY_UPLOAD_PRESET'] ?? '';
  static String get cloudinaryCloudName => dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';
}
