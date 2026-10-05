import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../core/extensions/build_context_extensions.dart';
import '../../../../../../core/presentation/widgets/widgets.dart';

class PhotoUpdateWidget extends StatefulWidget {
  final String? photoUrl;
  final String initials;
  final ValueChanged<File> onPhotoSelected;
  final VoidCallback onPhotoRemoved;

  const PhotoUpdateWidget({
    super.key,
    this.photoUrl,
    required this.initials,
    required this.onPhotoSelected,
    required this.onPhotoRemoved,
  });

  @override
  State<PhotoUpdateWidget> createState() => _PhotoUpdateWidgetState();
}

class _PhotoUpdateWidgetState extends State<PhotoUpdateWidget> {
  File? _selectedImage;
  bool _removed = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 400,
        maxHeight: 400,
        imageQuality: 10,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _removed = false;
        });
        widget.onPhotoSelected(_selectedImage!);
      }
    } catch (e, stackTrace) {
      if (mounted) {
        debugPrint('$e');
        debugPrintStack(stackTrace: stackTrace);
        AppSnackBar.error(context, context.l10n.profilePickImageError);
      }
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(context.l10n.profilePhotoGallery),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(context.l10n.profilePhotoCamera),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            if (_selectedImage != null ||
                (widget.photoUrl != null && !_removed))
              ListTile(
                leading: Icon(Icons.delete_outline, color: context.cs.error),
                title: Text(
                  context.l10n.profilePhotoRemove,
                  style: TextStyle(color: context.cs.error),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _selectedImage = null;
                    _removed = true;
                  });
                  widget.onPhotoRemoved();
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0).copyWith(bottom: 30),
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            UserAvatar(
              size: 120,
              initials: widget.initials,
              photoUrl: _removed ? null : widget.photoUrl,
              file: _selectedImage,
            ),
            // Edit Icon Overlay
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: _showImageSourceDialog,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.cs.primary,
                    border: Border.all(color: context.cs.surface, width: 3),
                  ),
                  child: Icon(
                    Icons.edit,
                    size: 18,
                    color: context.cs.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
