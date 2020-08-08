class NoteCreate {
  var title;
  var description;

  NoteCreate(this.title, this.description);

  Map<String, dynamic> toJson() {
    return {'title': this.title, 'description': this.description};
  }
}
