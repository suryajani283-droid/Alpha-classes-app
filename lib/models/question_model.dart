class QuestionModel {
  final int id;
  final int testId;
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String answer;
  String? selectedOption;

  QuestionModel({required this.id, required this.testId, required this.question,
    required this.optionA, required this.optionB, required this.optionC,
    required this.optionD, required this.answer, this.selectedOption});

  factory QuestionModel.fromMap(Map<String, dynamic> map) => QuestionModel(
    id: map['id'],
    testId: map['test_id'],
    question: map['question'],
    optionA: map['option_a'],
    optionB: map['option_b'],
    optionC: map['option_c'],
    optionD: map['option_d'],
    answer: map['answer'],
  );
}
