import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/user_info/presentation/build_length_field.dart';
import 'package:crosstrack_italia/features/user_info/presentation/build_dropdown_button_form_field.dart';
import 'package:crosstrack_italia/features/user_info/presentation/build_list_field.dart';
import 'package:crosstrack_italia/features/user_info/presentation/build_text_field.dart';
import 'package:crosstrack_italia/features/user_info/providers/owned_tracks_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditTrackScreen extends StatefulWidget {
  final Track track;

  EditTrackScreen({required this.track});

  @override
  _EditTrackScreenState createState() => _EditTrackScreenState();
}

class _EditTrackScreenState extends State<EditTrackScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _motoclubController;
  late TextEditingController _categoryController;
  late TextEditingController _terrainTypeController;
  late TextEditingController _lengthController;
  late TextEditingController _hasMinicrossController;
  late TextEditingController _servicesController;
  late List<TextEditingController> _phoneControllers;
  late List<TextEditingController> _faxControllers;
  late List<String> _phoneNumbers;
  late List<String> _faxNumbers;
  late TextEditingController _emailController;
  late TextEditingController _websiteController;
  late TextEditingController _infoController;
  late Set<String> _selectedLicenses;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.track.trackName);
    _motoclubController = TextEditingController(text: widget.track.motoclub);
    _categoryController = TextEditingController(text: widget.track.category);
    _terrainTypeController =
        TextEditingController(text: widget.track.terrainType);
    _lengthController = TextEditingController(
        text: widget.track.trackLength.replaceFirst(' m', ''));
    _hasMinicrossController =
        TextEditingController(text: widget.track.hasMinicross);
    _servicesController = TextEditingController(
      text: widget.track.services?.entries
              .map((e) => '${e.key}: ${e.value}')
              .join(', ') ??
          '',
    );
    _phoneNumbers = List<String>.from(widget.track.phones);
    _phoneControllers = _phoneNumbers
        .map((phoneNumber) => TextEditingController(text: phoneNumber))
        .toList();
    _faxNumbers = List<String>.from(widget.track.fax);
    _faxControllers = _faxNumbers
        .map((faxNumber) => TextEditingController(text: faxNumber))
        .toList();
    _emailController = TextEditingController(text: widget.track.email);
    _websiteController = TextEditingController(text: widget.track.website);
    _infoController = TextEditingController(text: widget.track.info);
    _selectedLicenses = Set<String>.from(widget.track.acceptedLicenses);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _motoclubController.dispose();
    _categoryController.dispose();
    _terrainTypeController.dispose();
    _lengthController.dispose();
    _hasMinicrossController.dispose();
    _servicesController.dispose();
    _phoneControllers.forEach((controller) => controller.dispose());
    _faxControllers.forEach((controller) => controller.dispose());
    _emailController.dispose();
    _websiteController.dispose();
    _infoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _isUpdating = false;
    final List<String> categories = ['1', '2', '3', '4', '5'];
    final List<String> licenses = ['fmi', 'uisp', 'asi', 'csen', 'asc'];

    Widget buildAddButton({
      required List<String> numbers,
      required String buttonText,
      required List<TextEditingController> controllers,
    }) {
      return ElevatedButton(
        child: Text(buttonText),
        onPressed: () {
          setState(() {
            numbers.add('');
            controllers.add(TextEditingController());
          });
        },
      );
    }

    Widget _buildSaveButton(GlobalKey<FormState> formKey) {
      return Consumer(
        builder: (context, ref, child) => ElevatedButton(
          onPressed: _isUpdating
              ? null
              : () async {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      _isUpdating = true;
                    });
                    // Save the form fields in a Track object
                    Track updatedTrack = widget.track.copyWith(
                      trackName: _nameController.text,
                      motoclub: _motoclubController.text,
                      category: _categoryController.text,
                      acceptedLicenses: _selectedLicenses.toList(),
                      terrainType: _terrainTypeController.text,
                      trackLength: _lengthController.text,
                      hasMinicross: _hasMinicrossController.text,
                      services:
                          _servicesController.text.split(', ').asMap().map(
                                (key, value) => MapEntry(
                                  value.split(': ')[0].replaceAll(' ', '_'),
                                  value.split(': ')[1],
                                ),
                              ),
                      phones: _phoneControllers
                          .map((controller) => controller.text)
                          .toList(),
                      fax: _faxControllers
                          .map((controller) => controller.text)
                          .toList(),
                      email: _emailController.text,
                      website: _websiteController.text,
                      info: _infoController.text,
                    );

                    // Update the track in the data source
                    await ref
                        .read(ownedTracksNotifierProvider.notifier)
                        .updateTrackInfo(updatedTrack);

                    // Show a success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Tracciato modificato correttamente')),
                    );

                    setState(() {
                      _isUpdating = false;
                    });

                    Navigator.pop(context);
                  }
                },
          child:
              _isUpdating ? CircularProgressIndicator() : Text('Save Changes'),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Modifica Tracciato'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              buildTextField(
                controller: _nameController,
                labelText: 'Track Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a track name';
                  }
                  return null;
                },
              ),
              buildTextField(
                controller: _motoclubController,
                labelText: 'Motoclub',
              ),
              buildDropdownButtonFormField(
                _categoryController.text.isEmpty
                    ? categories.first
                    : _categoryController.text,
                'Category',
                categories,
                (newValue) {
                  setState(() {
                    _categoryController.text = newValue;
                  });
                },
              ),
              buildListField(
                items: licenses,
                labelText: 'Accepted Licenses',
                itemBuilder: (context, index) {
                  String license = licenses[index];
                  return CheckboxListTile(
                    title: Text(license.toUpperCase()),
                    subtitle: Image.asset(
                      'assets/images/license_img/logo-$license.jpg',
                      height: 50.r,
                      width: 50.r,
                    ),
                    value: _selectedLicenses.contains(license),
                    onChanged: (bool? newValue) {
                      setState(() {
                        if (newValue == true) {
                          _selectedLicenses.add(license);
                        } else {
                          _selectedLicenses.remove(license);
                        }
                      });
                    },
                  );
                },
              ),
              buildTextField(
                controller: _terrainTypeController,
                labelText: 'Terrain Type',
              ),
              buildLengthField(lengthController: _lengthController),
              buildDropdownButtonFormField(
                _hasMinicrossController.text.isEmpty ||
                        _hasMinicrossController.text == '-'
                    ? 'no'
                    : _hasMinicrossController.text,
                'Minicross',
                ['si', 'no'],
                (newValue) {
                  setState(() {
                    _hasMinicrossController.text = newValue;
                  });
                },
              ),
              buildListField(
                items: _servicesController.text.split(', '),
                controller: _servicesController,
                labelText: 'Services',
                itemBuilder: (context, index) {
                  var service =
                      _servicesController.text.split(', ')[index].split(': ');
                  return ListTile(
                    title: Text(service[0].replaceFirst('_', ' ')),
                    trailing: Container(
                      width: MediaQuery.of(context).size.width *
                          0.3, // adjust the width as needed
                      child: DropdownButtonFormField<String>(
                        value: service[1].trim() == 'si' ? 'si' : 'no',
                        decoration: InputDecoration(
                          labelText: 'Value',
                        ),
                        items: <String>['si', 'no']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color:
                                    value == 'si' ? Colors.green : Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            var services = _servicesController.text.split(', ');
                            services[index] = '${service[0]}: ${newValue!}';
                            _servicesController.text = services.join(', ');
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
              buildListField(
                items: _phoneNumbers,
                labelText: 'Phone Number',
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          // initialValue: _phoneNumbers[index],
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                          ),
                          keyboardType: TextInputType.phone,
                          controller: _phoneControllers[index],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a Phone Number';
                            }
                            // Add additional validation for numbers here
                            return null;
                          },
                          onSaved: (newValue) {
                            setState(() {
                              _phoneNumbers[index] = newValue!;
                              _phoneControllers[index].text = newValue;
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _phoneNumbers.removeAt(index);
                            _phoneControllers.removeAt(index).dispose();
                          });
                        },
                      ),
                    ],
                  );
                },
              ),
              buildAddButton(
                numbers: _phoneNumbers,
                buttonText: 'Add Phone Number',
                controllers: _phoneControllers,
              ),
              buildListField(
                items: _faxNumbers,
                labelText: 'Fax Number',
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          // initialValue: _faxNumbers[index],
                          decoration: InputDecoration(
                            labelText: 'Fax Number',
                          ),
                          keyboardType: TextInputType.phone,
                          controller: _faxControllers[index],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a Fax Number';
                            }
                            // Add additional validation for numbers here
                            return null;
                          },
                          onSaved: (newValue) {
                            setState(() {
                              _faxNumbers[index] = newValue!;
                              _faxControllers[index].text = newValue;
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _faxNumbers.removeAt(index);
                            _faxControllers.removeAt(index).dispose();
                          });
                        },
                      ),
                    ],
                  );
                },
              ),
              buildAddButton(
                numbers: _faxNumbers,
                buttonText: 'Add Fax Number',
                controllers: _faxControllers,
              ),
              buildTextField(
                controller: _emailController,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  } else if (!RegExp(
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              buildTextField(
                controller: _websiteController,
                labelText: 'Website',
                keyboardType: TextInputType.url,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a website';
                  }
                  return null;
                },
              ),
              buildTextField(
                controller: _infoController,
                labelText: 'Info',
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                maxLines: null,
              ),
              _buildSaveButton(_formKey),
            ],
          ),
        ),
      ),
    );
  }
}
