class Athkar {
  Athkar({
    required this.id,
    required this.text,
    required this.count,
    required this.audio,
    required this.filename,
  });

  final int? id;
  final String? text;
  final int? count;
  final String? audio;
  final String? filename;

  factory Athkar.fromJson(Map<String, dynamic> json) {
    return Athkar(
      id: json["id"],
      text: json["text"],
      count: json["count"],
      audio: json["audio"],
      filename: json["filename"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "count": count,
        "audio": audio,
        "filename": filename,
      };

  @override
  String toString() {
    return "$id, $text, $count, $audio, $filename, ";
  }
}
