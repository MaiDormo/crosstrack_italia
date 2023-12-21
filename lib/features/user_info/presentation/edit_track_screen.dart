import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:flutter/material.dart';

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
  late TextEditingController _phonesController;
  late TextEditingController _faxController;
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
    _lengthController = TextEditingController(text: widget.track.trackLength);
    _hasMinicrossController =
        TextEditingController(text: widget.track.hasMinicross);
    _servicesController = TextEditingController(
      text: widget.track.services?.entries
              .map((e) => '${e.key}: ${e.value}')
              .join(', ') ??
          '',
    );
    _phonesController = TextEditingController(
      text: widget.track.phones.join(', '),
    );
    _faxController = TextEditingController(
      text: widget.track.fax.join(', '),
    );
    _emailController = TextEditingController(text: widget.track.email);
    _websiteController = TextEditingController(text: widget.track.website);
    _infoController = TextEditingController(text: widget.track.info);
    _selectedLicenses = Set<String>.from(widget.track.acceptedLicenses);
  }

  @override
  Widget build(BuildContext context) {
    List<String> _phoneNumbers = _phonesController.text.split(', ');
    List<String> _faxNumbers = _faxController.text.split(', ');
    final List<String> categories = ['1', '2', '3', '4', '5'];
    final List<String> licenses = ['fmi', 'uisp', 'asi', 'csen', 'asc'];

    Widget _buildAcceptedLicensesField() {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: licenses.length,
        itemBuilder: (context, index) {
          String license = licenses[index];
          return CheckboxListTile(
            title: Text(license.toUpperCase()),
            subtitle: Image.asset(
              'assets/images/license_img/logo-$license.jpg',
              height: 50,
              width: 50,
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
      );
    }

    Widget buildNumberField(List<String> numbers,
        TextEditingController controller, String labelText) {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: numbers.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: numbers[index],
                  decoration: InputDecoration(
                    labelText: labelText,
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a $labelText';
                    }
                    // Add additional validation for numbers here
                    return null;
                  },
                  onSaved: (newValue) {
                    numbers[index] = newValue!;
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    numbers.removeAt(index);
                    controller.text = numbers.join(', ');
                  });
                },
              ),
            ],
          );
        },
      );
    }

    Widget buildAddButton(List<String> numbers,
        TextEditingController controller, String buttonText) {
      return ElevatedButton(
        child: Text(buttonText),
        onPressed: () {
          setState(() {
            numbers.add('');
            controller.text = numbers.join(', ');
          });
        },
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Track'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              _buildTrackNameField(nameController: _nameController),
              // Add the remaining TextFormField widgets here
              _buildMotoclubField(motoclubController: _motoclubController),
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
              _buildAcceptedLicensesField(),
              _buildTerrainTypeField(
                  terrainTypeController: _terrainTypeController),
              _buildLengthField(lengthController: _lengthController),
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
                controller: _phonesController,
                labelText: 'Phone Number',
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: _phoneNumbers[index],
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a Phone Number';
                            }
                            // Add additional validation for numbers here
                            return null;
                          },
                          onSaved: (newValue) {
                            _phoneNumbers[index] = newValue!;
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _phoneNumbers.removeAt(index);
                            _phonesController.text = _phoneNumbers.join(', ');
                          });
                        },
                      ),
                    ],
                  );
                },
              ),

              buildAddButton(
                _phoneNumbers,
                _phonesController,
                'Add Phone Number',
              ),

              buildListField(
                items: _faxNumbers,
                controller: _faxController,
                labelText: 'Fax Number',
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: _faxNumbers[index],
                          decoration: InputDecoration(
                            labelText: 'Fax Number',
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a Fax Number';
                            }
                            // Add additional validation for numbers here
                            return null;
                          },
                          onSaved: (newValue) {
                            _faxNumbers[index] = newValue!;
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _faxNumbers.removeAt(index);
                            _faxController.text = _faxNumbers.join(', ');
                          });
                        },
                      ),
                    ],
                  );
                },
              ),

              buildAddButton(
                _faxNumbers,
                _faxController,
                'Add Fax Number',
              ),
              _buildEmailField(emailController: _emailController),
              _buildWebsiteField(websiteController: _websiteController),
              _buildInfoField(infoController: _infoController),
              _buildSaveButton(_formKey),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildSaveButton(GlobalKey<FormState> formKey) {
  return ElevatedButton(
    onPressed: () {
      if (formKey.currentState!.validate()) {
        // Save the changes
      }
    },
    child: Text('Save Changes'),
  );
}

Widget _buildInfoField({
  required TextEditingController infoController,
}) {
  return buildTextField(
    controller: infoController,
    labelText: 'Info',
    keyboardType: TextInputType.multiline,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter a description';
      }
      return null;
    },
    maxLines: null,
  );
}

Widget _buildWebsiteField({
  required TextEditingController websiteController,
}) {
  return buildTextField(
    controller: websiteController,
    labelText: 'Website',
    keyboardType: TextInputType.url,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter a website';
      }
      return null;
    },
  );
}

Widget _buildEmailField({
  required TextEditingController emailController,
}) {
  return buildTextField(
    controller: emailController,
    labelText: 'Email',
    keyboardType: TextInputType.emailAddress,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter an email';
      } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
          .hasMatch(value)) {
        return 'Please enter a valid email';
      }
      return null;
    },
  );
}

Widget _buildLengthField({
  required TextEditingController lengthController,
}) {
  return Row(
    children: <Widget>[
      Expanded(
        child: buildTextField(
          controller: lengthController,
          labelText: 'Length',
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a length';
            }
            return null;
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text('m'),
      ),
    ],
  );
}

Widget _buildTerrainTypeField({
  required TextEditingController terrainTypeController,
}) {
  return buildTextField(
    controller: terrainTypeController,
    labelText: 'Terrain Type',
  );
}

Widget _buildMotoclubField({
  required TextEditingController motoclubController,
}) {
  return buildTextField(
    controller: motoclubController,
    labelText: 'Motoclub',
  );
}

Widget _buildTrackNameField({
  required TextEditingController nameController,
}) {
  return buildTextField(
    controller: nameController,
    labelText: 'Track Name',
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter a track name';
      }
      return null;
    },
  );
}

Widget buildDropdownButtonFormField(String value, String labelText,
    List<String> items, Function(String) onChanged) {
  return DropdownButtonFormField<String>(
    value: value,
    decoration: InputDecoration(
      labelText: labelText,
    ),
    items: items.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
    onChanged: (String? newValue) {
      onChanged(newValue!);
    },
  );
}

Widget buildTextField({
  required TextEditingController controller,
  required String labelText,
  TextInputType keyboardType = TextInputType.text,
  String? Function(String?)? validator,
  int? maxLines = 1,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
    ),
    keyboardType: keyboardType,
    validator: validator,
    maxLines: maxLines,
  );
}

Widget buildListField({
  required List<String> items,
  required TextEditingController controller,
  required String labelText,
  required Widget Function(BuildContext, int) itemBuilder,
}) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: items.length,
    itemBuilder: itemBuilder,
  );
}
