import 'package:json_annotation/json_annotation.dart';
import 'package:revanced_manager/utils/string.dart';

part 'patch.g.dart';

@JsonSerializable()
class Patch {
  final String name;
  final String description;
  final String version;
  final bool excluded;
  final List<String> dependencies;
  final List<Package> compatiblePackages;
