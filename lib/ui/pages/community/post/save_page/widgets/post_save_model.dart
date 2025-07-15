class PostSaveModel {
  final int id;
  final String content;
  final int runRecordId;
  final List<int> pictureIds;

  PostSaveModel({
    required this.id,
    required this.content,
    required this.runRecordId,
    required this.pictureIds,
  });

  factory PostSaveModel.fromMap(Map<String, dynamic> map) {
    return PostSaveModel(
      id: map['id'],
      content: map['content'],
      runRecordId: map['runRecordId'],
      pictureIds: List<int>.from(map['pictureIds'] ?? []),
    );
  }
}
