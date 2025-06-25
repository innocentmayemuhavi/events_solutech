import 'package:events_solutech/widgets/_stats_recent_activities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/customer_provider.dart';
import '../../providers/visits_provider.dart';
import '../../providers/activities_provider.dart';
import '../../models/_models.dart';

class AddVisitPage extends StatefulWidget {
  const AddVisitPage({super.key});

  @override
  State<AddVisitPage> createState() => _AddVisitPageState();
}

class _AddVisitPageState extends State<AddVisitPage> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();

  int? _selectedCustomerId;
  String _selectedStatus = 'Pending';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final List<int> _selectedActivities = [];

  bool _isSubmitting = false;

  @override
  void dispose() {
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer3<CustomersProvider, ActivitiesProvider, VisitsProvider>(
        builder:
            (
              context,
              customersProvider,
              activitiesProvider,
              visitsProvider,
              child,
            ) {
              if (customersProvider.isLoading || activitiesProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add New Visit',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 24),
                      _buildCustomerDropdown(customersProvider),
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Expanded(child: _buildDateSelector()),
                          const SizedBox(width: 12),
                          Expanded(child: _buildTimeSelector()),
                        ],
                      ),
                      const SizedBox(height: 16),

                      _buildLocationField(),
                      const SizedBox(height: 16),

                      // Visit Status
                      _buildStatusDropdown(),
                      const SizedBox(height: 16),

                      // Activities Selection
                      _buildActivitiesSelection(activitiesProvider),
                      const SizedBox(height: 16),

                      // Notes
                      _buildNotesField(),
                      const SizedBox(height: 24),

                      _buildSubmitButton(context),
                    ],
                  ),
                ),
              );
            },
      ),
    );
  }

  Widget _buildCustomerDropdown(CustomersProvider customersProvider) {
    return DropdownButtonFormField<int>(
      value: _selectedCustomerId,
      decoration: const InputDecoration(
        labelText: 'Select Customer',
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      validator: (value) {
        if (value == null) {
          return 'Please select a customer';
        }
        return null;
      },
      items: customersProvider.customers.map((customer) {
        return DropdownMenuItem<int>(
          value: customer.id,
          child: Text(customer.name),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedCustomerId = value;
        });
      },
    );
  }

  Widget _buildDateSelector() {
    return InkWell(
      onTap: () => _selectDate(context),
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Visit Date',
          prefixIcon: Icon(Icons.calendar_today),
        ),
        child: Text(
          '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
        ),
      ),
    );
  }

  Widget _buildTimeSelector() {
    return InkWell(
      onTap: () => _selectTime(context),
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Visit Time',
          prefixIcon: Icon(Icons.access_time),
        ),
        child: Text(
          '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
        ),
      ),
    );
  }

  Widget _buildLocationField() {
    return TextFormField(
      controller: _locationController,
      decoration: const InputDecoration(
        labelText: 'Visit Location',
        prefixIcon: Icon(Icons.location_on),
        hintText: 'Enter the visit location',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter a location';
        }
        return null;
      },
    );
  }

  Widget _buildStatusDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedStatus,
      decoration: const InputDecoration(
        labelText: 'Visit Status',
        prefixIcon: Icon(Icons.flag),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      items: ['Pending', 'Completed', 'Cancelled'].map((status) {
        return DropdownMenuItem<String>(
          value: status,
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: getStatusColor(status),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(status),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedStatus = value!;
        });
      },
    );
  }

  Widget _buildActivitiesSelection(ActivitiesProvider activitiesProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Activities (Optional)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: activitiesProvider.activities.map((activity) {
              final isSelected = _selectedActivities.contains(activity.id);
              return CheckboxListTile(
                title: Text(activity.description),
                value: isSelected,
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      _selectedActivities.add(activity.id);
                    } else {
                      _selectedActivities.remove(activity.id);
                    }
                  });
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildNotesField() {
    return TextFormField(
      controller: _notesController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        labelText: 'Notes (Optional)',
        prefixIcon: Icon(Icons.note),
        hintText: 'Add any additional notes about the visit',
      ),
      maxLines: 3,
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _isSubmitting ? null : () => _submitVisit(context),
        icon: _isSubmitting
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.save),
        label: Text(_isSubmitting ? 'Saving...' : 'Save Visit'),
        style: ElevatedButton.styleFrom(
          // backgroundColor: Theme.of(context).colorScheme.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color:
                  Theme.of(context).textTheme.titleSmall?.color ?? Colors.grey,
              width: 1.5,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _submitVisit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Combine date and time
      final visitDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      // Get the next available ID
      final visitsProvider = context.read<VisitsProvider>();
      final nextId = visitsProvider.visits.isEmpty
          ? 1
          : visitsProvider.visits
                    .map((v) => v.id)
                    .reduce((a, b) => a > b ? a : b) +
                1;

      // Create new visit
      final newVisit = Visit(
        id: nextId,
        customerId: _selectedCustomerId!,
        visitDate: visitDateTime,
        status: _selectedStatus,
        location: _locationController.text.trim(),
        notes: _notesController.text.trim(),
        activitiesDone: _selectedActivities,
        createdAt: DateTime.now(),
      );

      // Add visit to provider
      visitsProvider.addVisit(newVisit);

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Visit added successfully!'),
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: 'View',
              textColor: Colors.white,
              onPressed: () {
                // Navigate to visits page or show visit details
              },
            ),
          ),
        );

        // Clear form
        _clearForm();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error adding visit: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _clearForm() {
    setState(() {
      _selectedCustomerId = null;
      _selectedStatus = 'Pending';
      _selectedDate = DateTime.now();
      _selectedTime = TimeOfDay.now();
      _selectedActivities.clear();
    });
    _locationController.clear();
    _notesController.clear();
  }
}
