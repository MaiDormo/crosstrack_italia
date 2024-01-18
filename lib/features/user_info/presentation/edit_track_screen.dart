import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/features/user_info/notifiers/owned_tracks_notifier.dart';
import 'package:crosstrack_italia/features/user_info/presentation/edit_track_screen_widgets/build_remove_image_field.dart';
import 'package:crosstrack_italia/features/user_info/presentation/edit_track_screen_widgets/build_dropdown_button_form_field.dart';
import 'package:crosstrack_italia/features/user_info/presentation/edit_track_screen_widgets/build_add_image_field.dart';
import 'package:crosstrack_italia/features/user_info/presentation/edit_track_screen_widgets/build_list_field.dart';
import 'package:crosstrack_italia/features/user_info/presentation/edit_track_screen_widgets/build_text_field.dart';
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
  late Set<TrackLicense> _selectedLicenses;

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
    _selectedLicenses = Set<TrackLicense>.from(widget.track.acceptedLicenses);
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
    String _imagePath = '';
    const List<String> categories = ['1', '2', '3', '4', '5'];
    const List<TrackLicense> licenses = TrackLicense.values;

    buildAddButton({
      required List<String> numbers,
      required String buttonText,
      required List<TextEditingController> controllers,
    }) {
      return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.blueGrey, // choose a color that matches your app's design
          ),
          overlayColor: MaterialStateProperty.all<Color>(
            Colors.blueGrey
                .shade700, // choose a color that matches your app's design
          ),
          elevation: MaterialStateProperty.all<double>(2.0),
        ),
        onPressed: () {
          setState(() {
            numbers.add('');
            controllers.add(TextEditingController());
          });
        },
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    Future<void> _saveTrack(
      GlobalKey<FormState> formKey,
      WidgetRef ref,
    ) async {
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
          services: _servicesController.text.split(', ').asMap().map(
                (key, value) => MapEntry(
                  value.split(': ')[0].replaceAll(' ', '_'),
                  value.split(': ')[1],
                ),
              ),
          phones:
              _phoneControllers.map((controller) => controller.text).toList(),
          fax: _faxControllers.map((controller) => controller.text).toList(),
          email: _emailController.text,
          website: _websiteController.text,
          info: _infoController.text,
        );

        // Update the track in the data source
        await ref
            .read(ownedTracksNotifierProvider.notifier)
            .updateTrackInfo(updatedTrack);
        if (_imagePath.isNotEmpty) {
          await uploadImage(
              _imagePath, widget.track.region, widget.track.id, ref);
          ref.read(imageFieldProvider.notifier).clearImage();
        }

        ref.watch(imagesPathToBeDeletedProvider.notifier).deleteAll(
              ref,
            );

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tracciato modificato correttamente')),
        );

        setState(() {
          _isUpdating = false;
        });

        Navigator.pop(context);
      }
    }

    Widget _buildSaveButton(GlobalKey<FormState> formKey) {
      return Consumer(
        builder: (context, ref, child) => ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.blueGrey, // choose a color that matches your app's design
            ),
            overlayColor: MaterialStateProperty.all<Color>(
              Colors.blueGrey
                  .shade700, // choose a color that matches your app's design
            ),
            elevation: MaterialStateProperty.all<double>(2.0),
          ),
          onPressed: _isUpdating ? null : () => _saveTrack(formKey, ref),
          child: _isUpdating
              ? CircularProgressIndicator()
              : Text(
                  'Salva i cambiamenti',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          title: Text('Modifica Tracciato'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              buildTextField(
                context: context,
                controller: _nameController,
                labelText: 'Nome Tracciato',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Aggiungi un nome al tracciato';
                  }
                  return null;
                },
              ),
              buildTextField(
                context: context,
                controller: _motoclubController,
                labelText: 'Motoclub',
              ),
              buildDropdownButtonFormField(
                context,
                _categoryController.text.isEmpty
                    ? categories.first
                    : _categoryController.text,
                'Categoria',
                categories,
                (newValue) {
                  setState(() {
                    _categoryController.text = newValue;
                  });
                },
              ),
              buildListField(
                context: context,
                items: licenses.map((license) => license.toString()).toList(),
                labelText: 'Licenze accettate',
                itemBuilder: (context, index) {
                  TrackLicense license = licenses[index];
                  String licenseString = license.toString().split('.').last;
                  return ListTile(
                    title: Text(
                      licenseString.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white, // same color as the ListTile text
                        fontWeight: FontWeight
                            .bold, // same font weight as the ListTile text
                      ),
                    ),
                    subtitle: Image.asset(
                      'assets/images/license_img/logo-$licenseString.jpg',
                      height: 50.r,
                      width: 50.r,
                    ),
                    trailing: Tooltip(
                      message: _selectedLicenses.contains(license)
                          ? 'Attualmente aggiunta'
                          : 'Attualmente rimossa',
                      child: Switch(
                        value: _selectedLicenses.contains(license),
                        activeTrackColor: Colors.green,
                        inactiveThumbColor: Colors.red,
                        onChanged: (bool newValue) {
                          setState(() {
                            if (newValue) {
                              _selectedLicenses.add(license);
                            } else {
                              _selectedLicenses.remove(license);
                            }
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
              buildTextField(
                context: context,
                controller: _terrainTypeController,
                labelText: 'Tipo terreno',
              ),
              buildTextField(
                context: context,
                controller: _lengthController,
                labelText: 'Lunghezza (in metri)',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Anggiungi la lunghezza del tracciato';
                  }
                  return null;
                },
              ),
              Card(
                elevation: 2.0,
                margin:
                    EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 5.0.h),
                color: Color.fromRGBO(50, 65, 85, 0.9),
                child: ListTile(
                  title: Text(
                    'Minicross',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Tooltip(
                    message: _hasMinicrossController.text == 'si'
                        ? 'Attualmente si'
                        : 'Attualmente no',
                    child: Switch(
                      value: _hasMinicrossController.text == 'si',
                      activeTrackColor: Colors.green,
                      inactiveThumbColor: Colors.red,
                      onChanged: (bool newValue) {
                        setState(() {
                          _hasMinicrossController.text = newValue ? 'si' : 'no';
                        });
                      },
                    ),
                  ),
                ),
              ),
              buildListField(
                context: context,
                items: _servicesController.text.split(', '),
                controller: _servicesController,
                labelText: 'Servizi',
                itemBuilder: (context, index) {
                  var service =
                      _servicesController.text.split(', ')[index].split(': ');
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0.w),
                    title: Text(
                      service[0].replaceFirst('_', ' '),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    trailing: Tooltip(
                      message: service[1].trim() == 'si'
                          ? 'Attualmente si'
                          : 'Attualmente no',
                      child: Switch(
                        value: service[1].trim() == 'si',
                        activeTrackColor: Colors.green,
                        inactiveThumbColor: Colors.red,
                        onChanged: (bool newValue) {
                          setState(() {
                            var services = _servicesController.text.split(', ');
                            services[index] =
                                '${service[0]}: ${newValue ? 'si' : 'no'}';
                            _servicesController.text = services.join(', ');
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
              buildListField(
                context: context,
                items: _phoneNumbers,
                labelText: 'Phone Number',
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    leading: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(width: 1.0, color: Colors.white24),
                        ),
                      ),
                      child: Icon(Icons.phone, color: Colors.white),
                    ),
                    title: TextFormField(
                      controller: _phoneControllers[index],
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: 'Enter phone number',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          _phoneNumbers.removeAt(index);
                          _phoneControllers.removeAt(index).dispose();
                        });
                      },
                    ),
                  );
                },
              ),
              buildAddButton(
                numbers: _phoneNumbers,
                buttonText: 'Add Phone Number',
                controllers: _phoneControllers,
              ),
              buildListField(
                context: context,
                items: _faxNumbers,
                labelText: 'Fax Number',
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    leading: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(width: 1.0, color: Colors.white24),
                        ),
                      ),
                      child: Icon(Icons.fax, color: Colors.white),
                    ),
                    title: TextFormField(
                      controller: _faxControllers[index],
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: 'Inserisci Fax',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          _faxNumbers.removeAt(index);
                          _faxControllers.removeAt(index).dispose();
                        });
                      },
                    ),
                  );
                },
              ),
              buildAddButton(
                numbers: _faxNumbers,
                buttonText: 'Add Fax Number',
                controllers: _faxControllers,
              ),
              buildTextField(
                context: context,
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
                context: context,
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
                context: context,
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
              ImageField(
                track: widget.track,
                onChanged: (value) {
                  _imagePath = value;
                },
              ),
              RemoveImageField(
                track: widget.track,
              ),
              _buildSaveButton(_formKey),
            ],
          ),
        ),
      ),
    );
  }
}
