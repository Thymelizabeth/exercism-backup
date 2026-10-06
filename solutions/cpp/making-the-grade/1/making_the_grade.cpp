#include <algorithm>
#include <array>
#include <string>
#include <vector>

// Round down all provided student scores.
std::vector<int> round_down_scores(std::vector<double> student_scores) {
  auto result = std::vector<int>(student_scores.size());
  std::transform(student_scores.begin(), student_scores.end(), result.begin(),
                 [](double score) { return static_cast<int>(score); });
  return result;
}

// Count the number of failing students out of the group provided.
int count_failed_students(std::vector<int> student_scores) {
  return std::count_if(student_scores.begin(), student_scores.end(),
                       [](int score) { return score <= 40; });
}

// Create a list of grade thresholds based on the provided highest grade.
std::array<int, 4> letter_grades(int highest_score) {
  std::array<int, 4> result = {};
  std::generate(result.begin(), result.end(),
                [n = 41, highest_score]() mutable {
                  int result = n;
                  n += (highest_score - 40) / 4;
                  return result;
                });
  return result;
}

// Organize the student's rank, name, and grade information in ascending order.
std::vector<std::string>
student_ranking(std::vector<int> student_scores,
                std::vector<std::string> student_names) {
  auto result = std::vector<std::string>(student_names.size());
  std::transform(
      student_scores.begin(), student_scores.end(), student_names.begin(),
      result.begin(), [i = 1](int score, std::string name) mutable {
        return std::to_string(i++) + ". " + name + ": " + std::to_string(score);
      });
  return result;
}

// Create a string that contains the name of the first student to make a perfect
// score on the exam.
std::string perfect_score(std::vector<int> student_scores,
                          std::vector<std::string> student_names) {
  for (size_t i = 0; i < student_scores.size(); i++) {
    if (student_scores[i] == 100)
      return student_names[i];
  }
  return "";
}
