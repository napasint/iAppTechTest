import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iapp/blocs/user_event.dart';
import 'package:iapp/blocs/user_state.dart';
import 'package:iapp/models/user.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final List<UserProfile> _users = [];
  int _nextUserId = 1; 

  UserBloc() : super(UserInitial()) {
    on<AddUserEvent>(_onAddUser);
    on<UpdateUserEvent>(_onEditUser);
    on<DeleteUserEvent>(_onDeleteUser);
    on<LoadUserDataEvent>(_onLoadUserData);

    add(LoadUserDataEvent());
  }

  void _onAddUser(AddUserEvent event, Emitter<UserState> emit) async {
    final newUserId = _nextUserId++;

    final newUser = UserProfile(
      userId: newUserId,
      name: event.newUser.name,
      email: event.newUser.email,
      api: event.newUser.api,
      address: event.newUser.address,
      phone: event.newUser.phone,
    );

    _users.add(newUser);

    try {
      emit(UserLoaded(
        List.from(_users),
      ));
    } catch (e) {
      emit(UserError('Failed to load user posts: $e'));
    }
  }

  void _onEditUser(UpdateUserEvent event, Emitter<UserState> emit) {
    final index =
        _users.indexWhere((user) => user.userId == event.updatedUser.userId);
    if (index != -1) {
      _users[index] = event.updatedUser;
      emit(UserLoaded(List.from(_users)));
    } else {
      emit(const UserError('User not found'));
    }
  }

  void _onDeleteUser(DeleteUserEvent event, Emitter<UserState> emit) {
    _users.removeWhere((user) => user.userId == event.userId);
    emit(UserLoaded(List.from(_users)));
  }

  void _onLoadUserData(LoadUserDataEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      emit(UserLoaded(List.from(_users)));
    } catch (e) {
      emit(UserError('Failed to load user data: $e'));
    }
  }
}
