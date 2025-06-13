import 'package:bsdoc_flutter/services/auth_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class DoctorRegister extends StatefulWidget {
  const DoctorRegister({super.key});

  @override
  State<DoctorRegister> createState() => _DoctorRegisterState();
}

class _DoctorRegisterState extends State<DoctorRegister>
    with SingleTickerProviderStateMixin {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;

  bool _isPasswordVisible = false;
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  String? _selectedFileName;
  String? _selectedFilePath;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    if (_isLoading) return;

    List<String> errors = [];

    if (_emailController.text.trim().isEmpty) {
      errors.add('Email cannot be empty!');
    }
    if (_passwordController.text.trim().isEmpty) {
      errors.add('Password cannot be empty!');
    }
    if (_selectedFilePath == null || _selectedFileName == null) {
      errors.add('Please attach proof/s!');
    }

    if (errors.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errors.first), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final message = await _authService.doctorSignup(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        filePath: _selectedFilePath!,
        fileName: _selectedFileName!,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceFirst("Exception", "")),
            backgroundColor: Colors.red,
          ),
        );
        debugPrint(e.toString());
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _selectedFileName = result.files.single.name;
        _selectedFilePath = result.files.single.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Focus.of(context).unfocus();
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: const Text('BSDOC'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Stack(
          children: [
            Container(
              constraints: const BoxConstraints.expand(),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height:
                              kToolbarHeight +
                              MediaQuery.of(context).padding.top +
                              20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Register as Doctor',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Divider(thickness: 1, color: Colors.grey[300]),
                        const SizedBox(height: 30),

                        //firstname
                        TextField(
                          controller: _firstNameController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            labelStyle: TextStyle(),
                            filled: true,
                            fillColor: Colors.grey.withAlpha(
                              (255 * 0.1).round(),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Colors.tealAccent,
                                width: 1.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.white.withAlpha(
                                  (255 * 0.3).round(),
                                ),
                                width: 1,
                              ),
                            ),
                            prefixIcon: Icon(Icons.person, color: Colors.black),
                          ),
                          onChanged: (text) {},
                          onSubmitted: (text) {},
                        ),
                        SizedBox(height: 15),

                        //lastname
                        TextField(
                          controller: _lastNameController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                            labelStyle: TextStyle(),
                            filled: true,
                            fillColor: Colors.grey.withAlpha(
                              (255 * 0.1).round(),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Colors.tealAccent,
                                width: 1.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.white.withAlpha(
                                  (255 * 0.3).round(),
                                ),
                                width: 1,
                              ),
                            ),
                            prefixIcon: Icon(Icons.person, color: Colors.black),
                          ),
                          onChanged: (text) {},
                          onSubmitted: (text) {},
                        ),
                        SizedBox(height: 15),

                        //email
                        TextField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(),
                            filled: true,
                            fillColor: Colors.grey.withAlpha(
                              (255 * 0.1).round(),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Colors.tealAccent,
                                width: 1.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.white.withAlpha(
                                  (255 * 0.3).round(),
                                ),
                                width: 1,
                              ),
                            ),
                            prefixIcon: Icon(Icons.email, color: Colors.black),
                          ),
                          onChanged: (text) {},
                          onSubmitted: (text) {},
                        ),
                        SizedBox(height: 15),

                        //password
                        TextField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(),
                            filled: true,
                            fillColor: Colors.grey.withAlpha(
                              (255 * 0.1).round(),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Colors.tealAccent,
                                width: 1.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.white.withAlpha(
                                  (255 * 0.3).round(),
                                ),
                                width: 1,
                              ),
                            ),
                            prefixIcon: Icon(Icons.person, color: Colors.black),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          onChanged: (text) {},
                          onSubmitted: (text) {},
                        ),
                        SizedBox(height: 15),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                bottom: 6,
                              ),
                              child: Text(
                                'Upload File (PRC ID)',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                FilePickerResult? result = await FilePicker
                                    .platform
                                    .pickFiles(
                                      allowMultiple: false,
                                      type: FileType.custom,
                                      allowedExtensions: ['jpg', 'png', 'pdf'],
                                    );

                                if (result != null) {
                                  setState(() {
                                    _selectedFilePath =
                                        result.files.single.path!;
                                    _selectedFileName =
                                        result.files.single.name;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withAlpha(
                                    (255 * 0.1).round(),
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Colors.white.withAlpha(
                                      (255 * 0.3).round(),
                                    ),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.upload,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        _selectedFileName ?? 'Choose File',
                                        style: TextStyle(
                                          color: _selectedFileName == null
                                              ? Colors.black.withAlpha((255 * 0.8).round())
                                              : Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        FractionallySizedBox(
                          widthFactor: 1,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleRegister,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                59,
                                209,
                                194,
                              ),
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(20),
                              ),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3,
                                    ),
                                  )
                                : const Text(
                                    'Submit',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
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
