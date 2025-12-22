import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/address_model.dart';
import '../services/address_service.dart';

class AddAddressSheet extends StatefulWidget {
  final Address? editAddress;

  const AddAddressSheet({super.key, this.editAddress});

  @override
  State<AddAddressSheet> createState() => _AddAddressSheetState();
}

class _AddAddressSheetState extends State<AddAddressSheet> {
  final _formKey = GlobalKey<FormState>();

  final fullName = TextEditingController();
  final phone = TextEditingController();
  final street = TextEditingController();
  final locality = TextEditingController();
  final pincode = TextEditingController();
  final city = TextEditingController();
  final stateCtl = TextEditingController();
  String selectedType = 'Home';

  final AddressService addressService = AddressService();

  @override
  void initState() {
    super.initState();

    // Pre-fill fields if editing
    if (widget.editAddress != null) {
      final a = widget.editAddress!;
      fullName.text = a.fullName;
      phone.text = a.phoneNumber;
      street.text = a.street;
      locality.text = a.locality;
      pincode.text = a.pincode;
      city.text = a.city;
      stateCtl.text = a.state;
      selectedType = a.type;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets.add(const EdgeInsets.all(16)),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.editAddress == null ? "Add New Address" : "Edit Address",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              _buildField(fullName, "Full Name"),
              _buildField(phone, "Phone Number", keyboard: TextInputType.phone),
              _buildField(street, "Street / Landmark"),
              _buildField(locality, "Locality"),
              _buildField(city, "City"),
              _buildField(stateCtl, "State"),
              _buildField(pincode, "Pincode", keyboard: TextInputType.number),

              const SizedBox(height: 10),
              Row(
                children: [
                  const Text("Type: "),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value: selectedType,
                    items: ["Home", "Work", "Other"]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedType = value!;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final address = Address(
                      id: widget.editAddress?.id ?? "",
                      fullName: fullName.text,
                      phoneNumber: phone.text,
                      street: street.text,
                      locality: locality.text,
                      pincode: pincode.text,
                      city: city.text,
                      state: stateCtl.text,
                      type: selectedType,
                    );

                    if (widget.editAddress == null) {
                      await addressService.addAddress(address);
                    } else {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('addresses')
                          .doc(address.id)
                          .update(address.toMap());
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(
                  widget.editAddress == null ? "Save Address" : "Update Address",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label,
      {TextInputType keyboard = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return "Required";
          return null;
        },
      ),
    );
  }
}
