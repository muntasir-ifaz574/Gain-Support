import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../models/ticket_model.dart';

class TicketDetailScreen extends ConsumerWidget {
  const TicketDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticket = ModalRoute.of(context)!.settings.arguments as Ticket;

    final dateFormatted = DateFormat(
      'dd MMM yyyy - hh:mm a',
    ).format(ticket.date);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Ticket Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildStatusBadge(ticket.status, isStatus: true),
                const SizedBox(width: 8),
                if (ticket.priority == 'Urgent')
                  _buildStatusBadge(ticket.priority, isUrgent: true)
                else
                  _buildStatusBadge(ticket.priority, isUrgent: false),
              ],
            ),
            const SizedBox(height: 16),

            Text(
              'Ticket #${ticket.id}',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              ticket.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.primary,
                    child: Text(
                      ticket.senderName[0],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ticket.senderName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        dateFormatted,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Divider(),
            const SizedBox(height: 24),
            const Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'This is a simulated description for the ticket. In a real application, the ticket model would contain a full description field detailing the user\'s issue.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 24),

            if (ticket.tags.isNotEmpty) ...[
              const Text(
                'Tags',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: ticket.tags.map((t) => Chip(label: Text(t))).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(
    String text, {
    bool isUrgent = false,
    bool isStatus = false,
  }) {
    Color bgColor = AppColors.info.withValues(alpha: 0.1);
    Color textColor = AppColors.info;

    if (isUrgent) {
      bgColor = AppColors.warning.withValues(alpha: 0.1);
      textColor = AppColors.warning;
    } else if (isStatus) {
      if (text == 'New') {
        bgColor = Colors.green.withValues(alpha: 0.1);
        textColor = Colors.green;
      } else {
        bgColor = Colors.grey.withValues(alpha: 0.1);
        textColor = Colors.grey;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
