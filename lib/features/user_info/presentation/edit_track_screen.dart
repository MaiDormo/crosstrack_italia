import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../track/models/track.dart';
import '../../track/models/typedefs/typedefs.dart';
import '../notifiers/owned_tracks_notifier.dart';
import 'edit_track_screen_widgets/build_add_image_field.dart';
import 'edit_track_screen_widgets/build_remove_image_field.dart';

class EditTrackScreen extends StatefulWidget {
  final Track track;

  const EditTrackScreen({super.key, required this.track});

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
  bool _isUpdating = false;
  String _imagePath = '';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.track.trackName);
    _motoclubController = TextEditingController(text: widget.track.motoclub);
    _categoryController = TextEditingController(text: widget.track.category);
    _terrainTypeController = TextEditingController(text: widget.track.terrainType);
    _lengthController = TextEditingController(
        text: widget.track.trackLength.replaceFirst(' m', ''));
    _hasMinicrossController = TextEditingController(text: widget.track.hasMinicross);
    _servicesController = TextEditingController(
      text: widget.track.services?.entries
              .map((e) => '${e.key}: ${e.value}')
              .join(', ') ?? '',
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
    for (var controller in _phoneControllers) {
      controller.dispose();
    }
    for (var controller in _faxControllers) {
      controller.dispose();
    }
    _emailController.dispose();
    _websiteController.dispose();
    _infoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const List<String> categories = ['1', '2', '3', '4', '5'];
    const List<TrackLicense> licenses = TrackLicense.values;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Modifica Tracciato',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.r),
          children: [
            // Track Name Section
            _buildSectionCard(
              context: context,
              title: 'Informazioni Base',
              icon: Icons.info_outline_rounded,
              children: [
                _buildTextField(
                  controller: _nameController,
                  label: 'Nome Tracciato',
                  icon: Icons.terrain_rounded,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Aggiungi un nome al tracciato';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12.h),
                _buildTextField(
                  controller: _motoclubController,
                  label: 'Motoclub',
                  icon: Icons.groups_rounded,
                ),
                SizedBox(height: 12.h),
                _buildDropdown(
                  value: _categoryController.text.isEmpty
                      ? categories.first
                      : _categoryController.text,
                  label: 'Categoria',
                  icon: Icons.category_rounded,
                  items: categories,
                  onChanged: (value) {
                    setState(() => _categoryController.text = value ?? '');
                  },
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Track Details Section
            _buildSectionCard(
              context: context,
              title: 'Dettagli Tracciato',
              icon: Icons.settings_rounded,
              children: [
                _buildTextField(
                  controller: _terrainTypeController,
                  label: 'Tipo Terreno',
                  icon: Icons.landscape_rounded,
                ),
                SizedBox(height: 12.h),
                _buildTextField(
                  controller: _lengthController,
                  label: 'Lunghezza (metri)',
                  icon: Icons.straighten_rounded,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Aggiungi la lunghezza del tracciato';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12.h),
                _buildSwitchTile(
                  title: 'Minicross',
                  subtitle: 'Il tracciato ha una sezione minicross',
                  value: _hasMinicrossController.text == 'si',
                  onChanged: (value) {
                    setState(() {
                      _hasMinicrossController.text = value ? 'si' : 'no';
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Licenses Section
            _buildSectionCard(
              context: context,
              title: 'Licenze Accettate',
              icon: Icons.card_membership_rounded,
              children: [
                ...licenses.map((license) {
                  final licenseString = license.toString().split('.').last;
                  return _buildSwitchTile(
                    title: licenseString.toUpperCase(),
                    value: _selectedLicenses.contains(license),
                    onChanged: (value) {
                      setState(() {
                        if (value) {
                          _selectedLicenses.add(license);
                        } else {
                          _selectedLicenses.remove(license);
                        }
                      });
                    },
                    trailing: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        'assets/images/license_img/logo-$licenseString.jpg',
                        height: 30.r,
                        width: 50.r,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => SizedBox(
                          height: 30.r,
                          width: 50.r,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),

            SizedBox(height: 16.h),

            // Services Section
            _buildSectionCard(
              context: context,
              title: 'Servizi',
              icon: Icons.miscellaneous_services_rounded,
              children: [
                if (_servicesController.text.isNotEmpty)
                  ..._servicesController.text.split(', ').asMap().entries.map((entry) {
                    final index = entry.key;
                    final service = entry.value.split(': ');
                    if (service.length < 2) return const SizedBox.shrink();
                    return _buildSwitchTile(
                      title: service[0].replaceAll('_', ' '),
                      value: service[1].trim() == 'si',
                      onChanged: (value) {
                        setState(() {
                          final services = _servicesController.text.split(', ');
                          services[index] = '${service[0]}: ${value ? 'si' : 'no'}';
                          _servicesController.text = services.join(', ');
                        });
                      },
                    );
                  }),
              ],
            ),

            SizedBox(height: 16.h),

            // Contact Section
            _buildSectionCard(
              context: context,
              title: 'Contatti',
              icon: Icons.contact_phone_rounded,
              children: [
                // Phone numbers
                ..._phoneNumbers.asMap().entries.map((entry) {
                  final index = entry.key;
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _phoneControllers[index],
                            label: 'Telefono ${index + 1}',
                            icon: Icons.phone_rounded,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        _buildIconButton(
                          icon: Icons.delete_outline_rounded,
                          color: const Color(0xFFEF4444),
                          onPressed: () {
                            setState(() {
                              _phoneNumbers.removeAt(index);
                              _phoneControllers.removeAt(index).dispose();
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }),
                _buildAddButton(
                  label: 'Aggiungi Telefono',
                  onPressed: () {
                    setState(() {
                      _phoneNumbers.add('');
                      _phoneControllers.add(TextEditingController());
                    });
                  },
                ),

                SizedBox(height: 16.h),

                // Fax numbers
                ..._faxNumbers.asMap().entries.map((entry) {
                  final index = entry.key;
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _faxControllers[index],
                            label: 'Fax ${index + 1}',
                            icon: Icons.fax_rounded,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        _buildIconButton(
                          icon: Icons.delete_outline_rounded,
                          color: const Color(0xFFEF4444),
                          onPressed: () {
                            setState(() {
                              _faxNumbers.removeAt(index);
                              _faxControllers.removeAt(index).dispose();
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }),
                _buildAddButton(
                  label: 'Aggiungi Fax',
                  onPressed: () {
                    setState(() {
                      _faxNumbers.add('');
                      _faxControllers.add(TextEditingController());
                    });
                  },
                ),

                SizedBox(height: 16.h),

                _buildTextField(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email_rounded,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 12.h),
                _buildTextField(
                  controller: _websiteController,
                  label: 'Sito Web',
                  icon: Icons.language_rounded,
                  keyboardType: TextInputType.url,
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Info Section
            _buildSectionCard(
              context: context,
              title: 'Informazioni Aggiuntive',
              icon: Icons.notes_rounded,
              children: [
                _buildTextField(
                  controller: _infoController,
                  label: 'Descrizione',
                  icon: Icons.description_rounded,
                  maxLines: 4,
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Images Section
            _buildSectionCard(
              context: context,
              title: 'Immagini',
              icon: Icons.image_rounded,
              children: [
                ImageField(
                  track: widget.track,
                  onChanged: (value) {
                    _imagePath = value;
                  },
                ),
                SizedBox(height: 12.h),
                RemoveImageField(track: widget.track),
              ],
            ),

            SizedBox(height: 24.h),

            // Save Button
            _buildSaveButton(context),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    size: 18.r,
                    color: colorScheme.primary,
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: colorScheme.onSurface.withValues(alpha: 0.06)),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: 14.sp,
        color: colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        prefixIcon: Icon(icon, color: colorScheme.primary, size: 20.r),
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.onSurface.withValues(alpha: 0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.onSurface.withValues(alpha: 0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEF4444)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required String label,
    required IconData icon,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        prefixIcon: Icon(icon, color: colorScheme.primary, size: 20.r),
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.onSurface.withValues(alpha: 0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.onSurface.withValues(alpha: 0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(12),
      items: items.map((item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      )).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildSwitchTile({
    required String title,
    String? subtitle,
    required bool value,
    required Function(bool) onChanged,
    Widget? trailing,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          if (trailing != null) ...[
            trailing,
            SizedBox(width: 12.w),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            activeColor: const Color(0xFF2E7D5A),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        icon: Icon(icon, color: color, size: 20.r),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildAddButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(Icons.add_rounded, size: 18.r),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        side: BorderSide(color: colorScheme.primary.withValues(alpha: 0.3)),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer(
      builder: (context, ref, child) => SizedBox(
        width: double.infinity,
        child: Material(
          color: _isUpdating ? colorScheme.primary.withValues(alpha: 0.6) : colorScheme.primary,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: _isUpdating ? null : () => _saveTrack(ref),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 18.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_isUpdating)
                    SizedBox(
                      width: 20.r,
                      height: 20.r,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  else ...[
                    Icon(Icons.save_rounded, color: Colors.white, size: 22.r),
                    SizedBox(width: 10.w),
                    Text(
                      'Salva Modifiche',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveTrack(WidgetRef ref) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isUpdating = true);

    try {
      final updatedTrack = widget.track.copyWith(
        trackName: _nameController.text,
        motoclub: _motoclubController.text,
        category: _categoryController.text,
        acceptedLicenses: _selectedLicenses.toList(),
        terrainType: _terrainTypeController.text,
        trackLength: _lengthController.text,
        hasMinicross: _hasMinicrossController.text,
        services: _servicesController.text.isNotEmpty
            ? _servicesController.text.split(', ').asMap().map(
                  (key, value) {
                    final parts = value.split(': ');
                    if (parts.length >= 2) {
                      return MapEntry(
                        parts[0].replaceAll(' ', '_'),
                        parts[1],
                      );
                    }
                    return MapEntry(parts[0], '');
                  },
                )
            : null,
        phones: _phoneControllers.map((c) => c.text).toList(),
        fax: _faxControllers.map((c) => c.text).toList(),
        email: _emailController.text,
        website: _websiteController.text,
        info: _infoController.text,
      );

      await ref.read(ownedTracksProvider.notifier).updateTrackInfo(updatedTrack);

      if (_imagePath.isNotEmpty) {
        await uploadImage(_imagePath, widget.track.region, widget.track.id, ref);
        ref.read(imageFieldProvider.notifier).clearImage();
      }

      ref.watch(imagesPathToBeDeletedProvider.notifier).deleteAll(ref);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Tracciato modificato correttamente'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: const Color(0xFF2E7D5A),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Errore: $e'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: const Color(0xFFEF4444),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isUpdating = false);
      }
    }
  }
}
