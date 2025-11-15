import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/lapak/data/models/checkout_form_data.dart';
import 'package:hijauin_frontend_mobile/features/lapak/presentation/views/checkout_review_page.dart';
import 'package:sizer/sizer.dart';

class CheckoutFormPage extends StatefulWidget {
  static const String routeName = 'checkout-form-page';
  const CheckoutFormPage({super.key});

  @override
  State<CheckoutFormPage> createState() => _CheckoutFormPageState();
}

class _CheckoutFormPageState extends State<CheckoutFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _recipientNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _provinceController = TextEditingController();
  final _postalCodeController = TextEditingController();

  @override
  void dispose() {
    _recipientNameController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _provinceController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final formData = CheckoutFormData(
        recipientName: _recipientNameController.text,
        phoneNumber: _phoneNumberController.text,
        address: _addressController.text,
        city: _cityController.text,
        province: _provinceController.text,
        postalCode: _postalCodeController.text,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckoutReviewPage(formData: formData),
        ),
      );
    }
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimaryText(
          text: label,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorTextDarkPrimary,
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Color(0xFF9E9E9E),
              fontSize: 14,
              fontFamily: 'Poppins',
            ),
            filled: true,
            fillColor: whiteColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xFFE0E0E0),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xFFE0E0E0),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: primaryColor600,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xFFF44336),
                width: 1,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 1.5.h,
            ),
          ),
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins',
            color: colorTextDarkPrimary,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$label tidak boleh kosong';
            }
            return null;
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorTextDarkPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: PrimaryText(
          text: 'Checkout',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: colorTextDarkPrimary,
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimaryText(
                      text: 'Isi alamatmu dulu ya!',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: colorTextDarkPrimary,
                    ),
                    SizedBox(height: 3.h),
                    _buildTextField(
                      label: 'Nama Penerima',
                      hint: 'Nama Penerima',
                      controller: _recipientNameController,
                    ),
                    SizedBox(height: 2.h),
                    _buildTextField(
                      label: 'Nomor Telepon',
                      hint: 'Nomor Telepon',
                      controller: _phoneNumberController,
                    ),
                    SizedBox(height: 2.h),
                    _buildTextField(
                      label: 'Alamat',
                      hint: 'Alamat',
                      controller: _addressController,
                      maxLines: 3,
                    ),
                    SizedBox(height: 2.h),
                    _buildTextField(
                      label: 'Kota/Kabupaten',
                      hint: 'Kota/Kabupaten',
                      controller: _cityController,
                    ),
                    SizedBox(height: 2.h),
                    _buildTextField(
                      label: 'Provinsi',
                      hint: 'Provinsi',
                      controller: _provinceController,
                    ),
                    SizedBox(height: 2.h),
                    _buildTextField(
                      label: 'Kode Pos',
                      hint: 'Kode Pos',
                      controller: _postalCodeController,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 6.h,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: PrimaryText(
                    text: 'Simpan',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: whiteColor,
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
