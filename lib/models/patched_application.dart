import 'dart:convert';
import 'dart:typed_data';
import 'package:json_annotation/json_annotation.dart';

part 'patched_application.g.dart';

@JsonSerializable()
class PatchedApplication {
  String name;
  String packageName;
  String originalPackageName;
  String version;
  final String apkFilePath;
  @JsonKey(
    fromJson: decodeBase64,
    toJson: encodeBase64,
  )
  Uint8List icon;
  DateTime patchDate;
  bool isRooted;
  bool isFromStorage;
  bool hasUpdates;
  List<String> appliedPatches;
  List<String> changelog;

  PatchedApplication({
    required this.name,
    required this.packageName,
    required this.originalPackageName,
    required this.version,
    required this.apkFilePath,
 
