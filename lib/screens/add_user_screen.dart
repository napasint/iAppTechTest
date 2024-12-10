import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iapp/blocs/user_bloc.dart';
import 'package:iapp/blocs/user_event.dart';
import 'package:iapp/models/user.dart';
import 'package:flutter/services.dart';

class AddUserScreen extends StatefulWidget {
  final UserProfile? user;
  const AddUserScreen({super.key, this.user});

  @override
  // ignore: library_private_types_in_public_api
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _apiController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.user != null) {
      _nameController.text = widget.user!.name;
      _emailController.text = widget.user!.email;
      _apiController.text = widget.user!.api;
      _addressController.text = widget.user!.address;
      _phoneController.text = widget.user!.phone;
    }
  }

  TextInputFormatter _emailFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String newText = newValue.text.trim();
      return newValue.copyWith(text: newText);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Email Input Field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  hintText: 'xxx@xxx.com',
                ),
                inputFormatters: [
                  _emailFormatter(),
                ],
              ),
              const SizedBox(height: 16),
              // API Input Field
              TextFormField(
                controller: _apiController,
                decoration: const InputDecoration(
                  labelText: 'API',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an API value';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Address Input Field
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Phone Input Field
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              // Submit Button
              SizedBox(
                width: screenWidth,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final newUser = UserProfile(
                        userId: widget.user?.userId ?? 0,
                        name: _nameController.text,
                        email: _emailController.text,
                        api: _apiController.text,
                        address: _addressController.text,
                        phone: _phoneController.text,
                      );

                      if (widget.user == null) {
                        BlocProvider.of<UserBloc>(context)
                            .add(AddUserEvent(newUser: newUser));
                      } else {
                        BlocProvider.of<UserBloc>(context)
                            .add(UpdateUserEvent(updatedUser: newUser));
                      }

                      Navigator.pop(context);
                    }
                  },
                  child: Text(widget.user == null ? 'Add User' : 'Update User'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
