sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class getDateLoadingState extends TaskState {}

final class getDateSucessState extends TaskState {}

final class getDateErrorState extends TaskState {}

//! S T A R T  T I M E ------------

final class startTimeLoadingState extends TaskState {}

final class startTimeSucessState extends TaskState {}

final class startTimeErrorState extends TaskState {}

//! E N D   T I M E ------------


final class endTimeLoadingState extends TaskState {}

final class endTimeSucessState extends TaskState {}

final class endTimeErrorState extends TaskState {}

//! Change Mark INDEX ------------

final class ChangeMarkIndexState extends TaskState {}

//! Insert Tasks ------------

final class instertLoadingState extends TaskState {}

final class instertsuccessState extends TaskState {}

final class instertErrorState extends TaskState {}

//! GetData Tasks ------------

final class getDataLoadingState extends TaskState {}

final class getDatasuccessState extends TaskState {}

final class getDataErrorState extends TaskState {}

//! updateData Tasks ------------

final class updateDataLoadingState extends TaskState {}

final class updateDatasuccessState extends TaskState {}

final class updateDataErrorState extends TaskState {}

//! Delete Tasks ------------

final class deleteDataLoadingState extends TaskState {}

final class deleteDatasuccessState extends TaskState {}

final class deleteDataErrorState extends TaskState {}

//! Filter Date Tasks ------------

final class selectedDateLoadingState extends TaskState {}

final class selectedDateerrorState extends TaskState {}

final class getThemeState extends TaskState {}
final class changeThemeState extends TaskState {}





