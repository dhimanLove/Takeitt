import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static final String SUPABASE_KEY = dotenv.env['SUPABASE_KEY']!;
  static final String SUPABASE_URL = dotenv.env['SUPABASE_URL']!;
}
