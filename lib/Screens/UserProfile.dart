import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/AppController.dart';
import 'AuthScreen.dart';

class UserProfile extends StatelessWidget {
   UserProfile({super.key});
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  radius: 25,
                ),
                title: const Text(
                  'Take Care!',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                subtitle: const Text(
                  'Richa Bose',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Settings Section
              const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),

              _buildSettingItem(Icons.notifications_none, 'Notification', 'Check your medicine notification'),
              _buildSettingItem(Icons.volume_up_outlined, 'Sound', 'Ring, Silent, Vibrate'),
              _buildSettingItem(Icons.person_outline, 'Manage Your Account', 'Password, Email ID, Phone Number'),
              _buildSettingItem(Icons.notifications_none, 'Notification', 'Check your medicine notification'),
              _buildSettingItem(Icons.notifications_none, 'Notification', 'Check your medicine notification'),

              const SizedBox(height: 20),

              // Device Section
              const Text(
                'Device',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildSettingItem(Icons.bluetooth, 'Connect', 'Bluetooth, Wi-Fi'),
                    _buildSettingItem(Icons.volume_up_outlined, 'Sound Option', 'Ring, Silent, Vibrate'),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Caretakers Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Caretakers',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '03',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    _buildCaretakerAvatar('Dipa Luna'),
                    const SizedBox(width: 16),
                    _buildCaretakerAvatar('Raz Soul'),
                    const SizedBox(width: 16),
                    _buildCaretakerAvatar('Sunny Tu'),
                    const SizedBox(width: 16),
                    _buildAddCaretakerButton(),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Doctor Section
              const Text(
                'Doctor',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),

              _buildAddDoctorButton(),

              const SizedBox(height: 20),

              // Footer Links
              _buildFooterLink('Privacy Policy'),
              _buildFooterLink('Terms of Use'),
              _buildFooterLink('Rate Us'),
              _buildFooterLink('Share'),

              const SizedBox(height: 20),

              // Log Out Button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () {
                   FirebaseAuth.instance.signOut();
                   Get.to(AuthScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.grey),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String title, String subtitle) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildCaretakerAvatar(String name) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 20,
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildAddCaretakerButton() {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey[200],
          child: const Icon(Icons.add, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        const Text(
          'Add',
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildAddDoctorButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey[200],
            child: const Icon(Icons.add, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add Your Doctor',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Or use ',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                'invite link',
                style: TextStyle(color: Colors.blue[400]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }
}