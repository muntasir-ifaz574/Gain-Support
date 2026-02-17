import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/filter_controller.dart';
import '../../controllers/ticket_controller.dart';
import '../../models/filter_model.dart';
import '../../core/constants/app_colors.dart';

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key});

  @override
  ConsumerState<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends ConsumerState<FilterScreen> {
  final Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    final filterFieldsAsync = ref.watch(filterControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Filters',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _formData.clear();
              });
              ref.read(ticketControllerProvider.notifier).clearFilters();
              Navigator.pop(context);
            },
            child: const Text(
              'Clear',
              style: TextStyle(color: AppColors.error),
            ),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(ticketControllerProvider.notifier)
                  .applyFilter(_formData);
              Navigator.pop(context);
            },
            child: const Text(
              'Apply',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: filterFieldsAsync.when(
        data: (fields) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: fields.length,
            separatorBuilder: (context, index) => const SizedBox(height: 24),
            itemBuilder: (context, index) {
              final field = fields[index];
              return _buildDynamicField(field);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
            Center(child: Text('Error loading filters: $err')),
      ),
    );
  }

  Widget _buildDynamicField(FilterField field) {
    switch (field.type) {
      case 'dropdown':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              field.label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            field.label == "Brand"
                ? _buildCheckboxGroup(field)
                : _buildDropdown(field),
          ],
        );
      case 'text':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              field.label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            if (field.label == "Tags") ...[
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search tags',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    [
                          'Tag one',
                          'Tag two',
                          'Tag three wit long text',
                          'Tag four',
                          'Tag five',
                          'Tag six with long text',
                          'Tag seven',
                        ]
                        .map(
                          (tag) => Chip(
                            label: Text(
                              tag,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.grey[300]!),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ] else
              TextField(
                decoration: InputDecoration(hintText: 'Enter ${field.label}'),
                onChanged: (val) => _formData[field.label] = val,
              ),
          ],
        );
      case 'date':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              field.label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  setState(() {
                    _formData[field.label] = date.toIso8601String();
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_formData[field.label] ?? 'Select Date'),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildCheckboxGroup(FilterField field) {
    if (field.options == null) return const SizedBox.shrink();
    List<String> selectedOptions = _formData[field.label] ?? [];

    return Column(
      children: field.options!.map((option) {
        final isSelected = selectedOptions.contains(option);
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: isSelected,
                  onChanged: (val) {
                    setState(() {
                      if (val == true) {
                        selectedOptions.add(option);
                      } else {
                        selectedOptions.remove(option);
                      }
                      _formData[field.label] = selectedOptions;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              if (option.contains("Gain"))
                const Icon(Icons.circle, color: Colors.blue, size: 28),
              if (option.contains("GainHQ"))
                const Icon(Icons.circle, color: Colors.green, size: 28),
              if (option.contains("GainSolution"))
                const Icon(Icons.circle, color: Colors.orange, size: 28),

              const SizedBox(width: 8),
              Text(
                option,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDropdown(FilterField field) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text('Select ${field.label.toLowerCase()}'),
          value: _formData[field.label],
          items: field.options?.map((opt) {
            return DropdownMenuItem(value: opt, child: Text(opt));
          }).toList(),
          onChanged: (val) {
            setState(() {
              _formData[field.label] = val;
            });
          },
        ),
      ),
    );
  }
}
