class QuestionModel {
  String? email;
  String? question;

  QuestionModel({this.email, this.question});
  factory QuestionModel.fromQuestions(map){
    return QuestionModel(
        email:map['email'],
        question:map['question']);

  }
  Map<String, dynamic> toQuestion() {
    return {
      'email': email,
      'question': question,
    };
  }
}