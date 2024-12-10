import 'package:equatable/equatable.dart';
import 'package:iapp/models/user.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Add User Event
class AddUserEvent extends UserEvent {
  final UserProfile newUser;

  AddUserEvent({required this.newUser});

  @override
  List<Object?> get props => [newUser];
}

// Update User Event (for editing an existing user)
class UpdateUserEvent extends UserEvent {
  final UserProfile updatedUser;

  UpdateUserEvent({required this.updatedUser});

  @override
  List<Object?> get props => [updatedUser];
}

// Delete User Event
class DeleteUserEvent extends UserEvent {
  final int userId;

  DeleteUserEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

// Load User Data Event (initial loading)
class LoadUserDataEvent extends UserEvent {}
