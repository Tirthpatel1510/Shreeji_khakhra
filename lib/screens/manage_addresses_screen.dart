import 'package:flutter/material.dart';
import '../services/address_service.dart';
import '../models/address_model.dart';
import '../widgets/add_address_sheet.dart';

class ManageAddressesScreen extends StatelessWidget {
  const ManageAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressService addressService = AddressService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Addresses"),
      ),

      body: StreamBuilder<List<Address>>(
        stream: addressService.getAddresses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final addresses = snapshot.data ?? [];

          if (addresses.isEmpty) {
            return const Center(
              child: Text(
                "No addresses added",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              final a = addresses[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text("${a.fullName} • ${a.phoneNumber}"),
                  subtitle: Text(
                    "${a.street}, ${a.locality},\n${a.city}, ${a.state} - ${a.pincode}\n(${a.type})",
                  ),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      addressService.deleteAddress(a.id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => const AddAddressSheet(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
