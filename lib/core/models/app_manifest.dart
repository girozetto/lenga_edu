class AppManifest {
  final String version;
  final List<Map<String, dynamic>> subjects;

  AppManifest({required this.version, required this.subjects});

  factory AppManifest.fromMap(Map<String, dynamic> map) {
    return AppManifest(
      version: map['version'],
      subjects: List<Map<String, dynamic>>.from(map['subjects']),
    );
  }

  Map<String, dynamic> toMap() {
    return {'version': version, 'subjects': subjects};
  }
}
