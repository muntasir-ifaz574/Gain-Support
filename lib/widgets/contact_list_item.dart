import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/contact_model.dart';
import '../core/constants/app_colors.dart';

class ContactListItem extends StatelessWidget {
  final Contact contact;

  const ContactListItem({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(contact.avatarUrl),
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () async {
                          final Uri emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: contact.email,
                          );
                          if (await canLaunchUrl(emailLaunchUri)) {
                            await launchUrl(emailLaunchUri);
                          }
                        },
                        child: _buildInfoRow(
                          Icons.email_outlined,
                          contact.email,
                        ),
                      ),
                      const SizedBox(height: 4),
                      InkWell(
                        onTap: () async {
                          final Uri telLaunchUri = Uri(
                            scheme: 'tel',
                            path: contact.phone,
                          );
                          if (await canLaunchUrl(telLaunchUri)) {
                            await launchUrl(telLaunchUri);
                          }
                        },
                        child: _buildInfoRow(
                          Icons.phone_outlined,
                          contact.phone,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildInfoRow(
                        Icons.location_on_outlined,
                        contact.location,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (ctx) => _buildActionSheet(ctx),
                      backgroundColor: Colors.transparent,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildActionSheet(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Edit'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            title: const Text('View tickets'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            title: const Text('Delete'),
            onTap: () => Navigator.pop(context),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
