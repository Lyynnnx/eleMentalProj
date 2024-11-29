import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mentalproj/models/patient.dart';

/// StateNotifier для управления массивом клиентов
class PatientNotifier extends StateNotifier<List<Patient>> {
  PatientNotifier() : super([]);

  /// Добавить нового клиента
  void addPatient(Patient patient) {
    state = [...state, patient]; // Создаём новый список с добавленным клиентом
  }

  /// Удалить клиента по индексу
  void removePatient(int index) {
    state = [...state]..removeAt(index); // Создаём новый список без клиента
  }

  /// Обновить клиента по индексу
  void updatePatient(int index, Patient updatedPatient) {
    final newState = [...state];
    if (index >= 0 && index < newState.length) {
      newState[index] = updatedPatient;
      state = newState;
    }
  }

  /// Очистить весь список
  void clearPatients() {
    state = [];
  }
}

/// StateNotifierProvider для доступа к PatientNotifier
final patientProvider =
    StateNotifierProvider<PatientNotifier, List<Patient>>((ref) {
  return PatientNotifier();
});