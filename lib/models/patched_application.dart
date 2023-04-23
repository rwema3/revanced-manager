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
 
