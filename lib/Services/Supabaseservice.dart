import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Supabaseservice extends GetxController{
  static final Supabaseservice instance = Get.find();
  static final SupabaseClient client = Supabase.instance.client;
}