import 'package:flutter/material.dart';

class ResultStateManager extends ChangeNotifier {
  // Dropdown values
  String? selectedExam;
  String? selectedSession;
  String? selectedClass;
  String? selectedSection;
  String? selectedSubject;

  // Dropdown options
  final List<String> examList = ['Mid Term', 'Final'];
  final List<String> sessionList = ['2023', '2024'];
  final List<String> classList = ['Class 1', 'Class 2'];
  final List<String> sectionList = ['A', 'B'];
  final List<String> subjectList = ['Math', 'Bangla'];

  // State
  bool isFormSubmitted = false;

  // Student Data
  int currentStudentIndex = 0;
  final List<Student> studentList = [
    Student(id: '101', name: 'শিশির', marks: ''),
    Student(id: '102', name: 'সাবরিনা', marks: ''),
    Student(id: '103', name: 'ফাতেমা', marks: ''),
    Student(id: '101', name: 'সুজন', marks: ''),
    Student(id: '102', name: 'সুমনা', marks: ''),
    Student(id: '103', name: 'তোহা', marks: ''),
    Student(id: '103', name: 'আব্দুল্লাহ', marks: ''),
    Student(id: '101', name: 'সিফাত', marks: ''),
    Student(id: '102', name: 'নাইম', marks: ''),
    Student(id: '103', name: 'ভোটু', marks: ''),
  ];

  // Dropdown Selection Methods
  void setExam(String? value) {
    selectedExam = value;
    selectedSession = null;
    selectedClass = null;
    selectedSection = null;
    selectedSubject = null;
    isFormSubmitted = false;
    notifyListeners();
  }

  void setSession(String? value) {
    selectedSession = value;
    selectedClass = null;
    selectedSection = null;
    selectedSubject = null;
    isFormSubmitted = false;
    notifyListeners();
  }

  void setClass(String? value) {
    selectedClass = value;
    selectedSection = null;
    selectedSubject = null;
    isFormSubmitted = false;
    notifyListeners();
  }

  void setSection(String? value) {
    selectedSection = value;
    isFormSubmitted = false;
    notifyListeners();
  }

  void setSubject(String? value) {
    selectedSubject = value;
    isFormSubmitted = false;
    notifyListeners();
  }

  // Form Submit
  void submitForm() {
    if (selectedExam != null &&
        selectedSession != null &&
        selectedClass != null &&
        selectedSection != null &&
        selectedSubject != null) {
      isFormSubmitted = true;
      currentStudentIndex = 0;
      notifyListeners();
    }
  }

  // Student Navigation
  void nextStudent() {
    if (currentStudentIndex < studentList.length - 1) {
      currentStudentIndex++;
      notifyListeners();
    }
  }

  void previousStudent() {
    if (currentStudentIndex > 0) {
      currentStudentIndex--;
      notifyListeners();
    }
  }

  // Update Marks
  void updateMarks(String marks) {
    studentList[currentStudentIndex].marks = marks;
    notifyListeners();
  }

  bool isInputLocked = false;

  void lockInput() {
    isInputLocked = true;
    notifyListeners();
  }

  void unlockInput() {
    isInputLocked = false;
    notifyListeners();
  }


  // Get current student
  Student get currentStudent => studentList[currentStudentIndex];

  void resetSelection() {
    selectedExam = null;
    selectedSession = null;
    selectedClass = null;
    selectedSection = null;
    selectedSubject = null;
    isFormSubmitted = false;
    currentStudentIndex = 0;
    for (var student in studentList) {
      student.marks = '';
    }
    notifyListeners();
  }
}

class Student {
  final String id;
  final String name;
  String marks;

  Student({required this.id, required this.name, required this.marks});
}
