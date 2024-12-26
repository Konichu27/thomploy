import 'package:flutter/material.dart';
import 'dart:async';

class AddListingPage extends StatefulWidget {
  const AddListingPage({required this.addListing, super.key});

  final FutureOr<void> Function(Map<String, Object> listing) addListing;

  @override
  State<AddListingPage> createState() => _AddListingPageState();
}

class _AddListingPageState extends State<AddListingPage> {
  IconData? _selectedIcon;
  final _formKey = GlobalKey<FormState>(debugLabel: '_AddListingPageState');
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _timeController = TextEditingController();
  final _paymentController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _iconError;

  Future<void> _pickIcon() async {
    final IconData? pickedIcon = await showDialog<IconData>(
      context: context,
      builder: (BuildContext context) {
        return IconPickerDialog(
          selectedIcon: _selectedIcon,
          onIconSelected: (icon) {
            setState(() {
              _selectedIcon = icon;
              _iconError = null;
            });
            Navigator.of(context).pop(icon);
          },
        );
      },
    );

    if (pickedIcon != null) {
      setState(() {
        _selectedIcon = pickedIcon;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Add New Listing',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // Yellow Content Section
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                    
                        // Icon Picker Container
                        GestureDetector(
                          onTap: _pickIcon,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: _selectedIcon != null
                                  ? Center(
                                      child: Icon(
                                        _selectedIcon,
                                        size: 150,
                                        color: Colors.grey,
                                      ),
                                    )
                                  : const Center(
                                      child: Icon(
                                        Icons.add,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        if (_iconError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              _iconError!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        const SizedBox(height: 20),
                    
                        // Form Fields
                        _buildFormField('Title', controller: _titleController),
                        const SizedBox(height: 12),
                        _buildFormField('Location', controller: _locationController),
                        const SizedBox(height: 12),
                        _buildFormField('Time', controller: _timeController),
                        const SizedBox(height: 12),
                        _buildFormField('Payment method', controller: _paymentController),
                        const SizedBox(height: 12),
                        _buildFormField('Description', controller: _descriptionController, maxLines: 5),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Add Listing Button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD84D),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                if (_selectedIcon == null) {
                  setState(() {
                    _iconError = 'Please select an icon';
                  });
                  return;
                }
                if (_formKey.currentState!.validate()) {
                  final listing = {
                    'icon': _selectedIcon!.codePoint,
                    'title': _titleController.text,
                    'location': _locationController.text,
                    'time': _timeController.text,
                    'payment': _paymentController.text,
                    'description': _descriptionController.text,
                  };
                  await widget.addListing(listing);
                  _titleController.clear();
                  _locationController.clear();
                  _timeController.clear();
                  _paymentController.clear();
                  _descriptionController.clear();
                  setState(() {
                    _selectedIcon = null;
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Add Listing',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(
    String placeholder,
    {TextEditingController? controller,
    int maxLines = 1}
    ) {
    return Container(
      decoration: _buildFieldBoxDecoration(),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: _buildFieldInputDecoration(placeholder),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $placeholder';
          }
          return null;
        },
      ),
    );
  }

  InputDecoration _buildFieldInputDecoration(String placeholder) {
    return InputDecoration(
      hintText: placeholder,
      hintStyle: const TextStyle(
        color: Colors.black87,
        fontSize: 16,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      border: InputBorder.none,
    );
  }

  BoxDecoration _buildFieldBoxDecoration() {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.5),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: Colors.black.withOpacity(0.1),
      ),
    );
  }
}

class IconPickerDialog extends StatelessWidget {
  final IconData? selectedIcon;
  final ValueChanged<IconData> onIconSelected;

  const IconPickerDialog({
    Key? key,
    this.selectedIcon,
    required this.onIconSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icons = [
      Icons.print,
      Icons.brush,
      Icons.book,
      Icons.edit,
      Icons.code,
      Icons.camera_alt,
      Icons.movie,
      Icons.music_note,
      Icons.language,
      Icons.campaign,
      Icons.web,
      Icons.headset,
      Icons.fitness_center,
      Icons.event,
      Icons.share,
      Icons.build,
      Icons.palette,
      Icons.pets,
      Icons.cleaning_services,
      Icons.more_horiz,
    ];

    return AlertDialog(
      title: const Text('Pick an Icon'),
      content: SingleChildScrollView(
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: icons.map((icon) {
            return GestureDetector(
              onTap: () => onIconSelected(icon),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: selectedIcon == icon ? Colors.amber : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: selectedIcon == icon ? Colors.white : Colors.black,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}