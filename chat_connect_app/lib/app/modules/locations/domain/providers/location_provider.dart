import 'package:chat_connect_app/app/modules/locations/domain/providers/controllers/location_controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final locationProviders = ChangeNotifierProvider((ref) => LocationController());
