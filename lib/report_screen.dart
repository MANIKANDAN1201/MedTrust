import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: ReportScreen(),
    theme: ThemeData(
      primarySwatch: Colors.deepPurple,
    ),
  ));
}

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _medicineNameController = TextEditingController();
  final _batchNumberController = TextEditingController();
  final _purchaseDetailsController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _pharmacyNameController = TextEditingController();
  final _dateOfPurchaseController = TextEditingController();
  File? _photo;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  Map<String, dynamic>? _profileData; // Store profile data here

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchProfileData(); // Fetch profile data on initialization
  }

  Future<void> _fetchProfileData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final profileSnapshot = await FirebaseFirestore.instance
            .collection(
                'users') // Ensure this matches your Firestore collection
            .doc(user.uid)
            .get();
        if (profileSnapshot.exists) {
          setState(() {
            _profileData = profileSnapshot.data();
            if (_profileData != null) {
              _nameController.text = _profileData!['name'] ?? '';
              _emailController.text = _profileData!['email'] ?? '';
              _phoneController.text = _profileData!['phone'] ?? '';
            }
          });
        } else {
          print('Profile document does not exist.');
        }
      } else {
        print('No user is currently signed in.');
      }
    } catch (e) {
      print('Failed to fetch profile data: $e');
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _photo = File(image.path);
      });
    }
  }

  Future<void> _createAndSendPdf(String reportId) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Text('Report Details',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text('Reporter Name: ${_nameController.text}'),
            pw.Text('Email: ${_emailController.text}'),
            pw.Text('Phone: ${_phoneController.text}'),
            pw.SizedBox(height: 20),
            pw.Text('Medicine Name: ${_medicineNameController.text}'),
            pw.Text('Batch Number: ${_batchNumberController.text}'),
            pw.Text('Purchase Details: ${_purchaseDetailsController.text}'),
            pw.Text('Pharmacy Name: ${_pharmacyNameController.text}'),
            pw.Text('Date of Purchase: ${_dateOfPurchaseController.text}'),
            pw.Text('Description: ${_descriptionController.text}'),
            pw.SizedBox(height: 20),
            if (_photo != null)
              pw.Image(
                pw.MemoryImage(_photo!.readAsBytesSync()),
                width: 100,
                height: 100,
                fit: pw.BoxFit.cover,
              ),
          ],
        ),
      ),
    );

    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/report_$reportId.pdf');
    await file.writeAsBytes(await pdf.save());

    final smtpServer = gmail('221501073@rajalakshmi.edu.in',
        'pufe zaik gfen bguu'); // Use the generated app password
    final message = Message()
      ..from = Address('MedTrustreports@gmail.com', 'MedTrust')
      ..recipients.add('221501074@rajalakshmi.edu.in')
      ..recipients
          .add('221501114@rajalakshmi.edu.in') // Use the recipient email
      ..subject = 'Counterfeit Medicine Report'
      ..text = 'Please find the attached PDF report.'
      ..attachments.add(FileAttachment(file));

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent. Response: $sendReport');
    } catch (e) {
      print('Message not sent. $e');
    }
  }

  Future<void> _submitReport() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        String? imageUrl;
        if (_photo != null) {
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('reports/${DateTime.now().millisecondsSinceEpoch}.jpg');
          final uploadTask = await storageRef.putFile(_photo!);
          imageUrl = await uploadTask.ref.getDownloadURL();
        }

        final reportRef =
            await FirebaseFirestore.instance.collection('Reports').add({
          'medicineName': _medicineNameController.text,
          'batchNumber': _batchNumberController.text,
          'purchaseDetails': _purchaseDetailsController.text,
          'pharmacyName': _pharmacyNameController.text,
          'dateOfPurchase': _dateOfPurchaseController.text,
          'description': _descriptionController.text,
          'imageUrl': imageUrl,
          'submittedAt': Timestamp.now(),
        });

        await _createAndSendPdf(reportRef.id);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Report submitted and emailed successfully!')),
        );

        _formKey.currentState?.reset();
        setState(() {
          _photo = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit report: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Counterfeit Medicine'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please provide the following details to report counterfeit medicine:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                _buildTextField(
                  label: 'Name',
                  controller: _nameController,
                  readOnly: true,
                ),
                SizedBox(height: 16),
                _buildTextField(
                  label: 'Email',
                  controller: _emailController,
                  readOnly: true,
                ),
                SizedBox(height: 16),
                _buildTextField(
                  label: 'Phone',
                  controller: _phoneController,
                  readOnly: true,
                ),
                SizedBox(height: 16),
                _buildTextField(
                  label: 'Medicine Name',
                  controller: _medicineNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the medicine name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                _buildTextField(
                  label: 'Batch Number',
                  controller: _batchNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the batch number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                _buildTextField(
                  label: 'Purchase Details',
                  controller: _purchaseDetailsController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter where the medicine was bought';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                _buildTextField(
                  label: 'Pharmacy Name',
                  controller: _pharmacyNameController,
                ),
                SizedBox(height: 16),
                _buildTextField(
                  label: 'Date of Purchase',
                  controller: _dateOfPurchaseController,
                ),
                SizedBox(height: 16),
                _buildTextField(
                  label: 'Description',
                  controller: _descriptionController,
                  maxLines: 3,
                ),
                SizedBox(height: 16),
                _photo != null
                    ? Image.file(
                        _photo!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      )
                    : Text('No image selected'),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Pick Image'),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitReport,
                    child: Text('Submit Report'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool readOnly = false,
    int? maxLines,
    FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
