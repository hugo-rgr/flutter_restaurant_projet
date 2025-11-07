import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/domain/user_logic.dart';
import 'package:flutter_restaurant_app/presentation/reservation/state/reservation_notifier.dart';
import 'package:flutter_restaurant_app/presentation/reservation/state/reservation_state.dart';
import 'package:flutter_restaurant_app/presentation/common/widgets/ore_button.dart';
import 'package:flutter_restaurant_app/presentation/common/widgets/ore_textfield.dart';
import 'package:flutter_restaurant_app/data/local/models/reservation.dart'
    as model;
import 'package:flutter_restaurant_app/services/prefs/prefs_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../common/base_page.dart';

class ReservationPage extends BasePage<ReservationNotifier, ReservationState> {
  ReservationPage({super.key}) : super(provider: reservationNotifierProvider);

  static const route = '/reservation';

  @override
  Widget buildContent(
    BuildContext context,
    WidgetRef ref,
    ReservationState state,
  ) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              labelColor: Colors.orange,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.orange,
              tabs: [
                Tab(text: 'Nouvelle Réservation'),
                Tab(text: 'Mes Réservations'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildNewReservationTab(context, ref, state, notifier),
                _buildMyReservationsTab(context, ref, state),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewReservationTab(
    BuildContext context,
    WidgetRef ref,
    ReservationState state,
    Refreshable<ReservationNotifier> notifier,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: NewReservationForm(notifier: notifier),
    );
  }

  Widget _buildMyReservationsTab(
    BuildContext context,
    WidgetRef ref,
    ReservationState state,
  ) {
    final user = ref.read(userProvider);
    return FutureBuilder<int?>(
      future: ref.read(prefsProvider).getInt('userId'),
      builder: (context, snapshot) {
        final isConnected = snapshot.data != null;

        if (user == null) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.login, size: 64, color: Colors.orange),
                  SizedBox(height: 24),
                  Text(
                    'Connectez-vous pour voir vos réservations',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Vous devez être connecté pour accéder à vos réservations',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: () {
                      DefaultTabController.of(context).animateTo(2);
                    },
                    icon: Icon(Icons.login),
                    label: Text('Se connecter'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state.reservations.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Aucune réservation',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: state.reservations.length,
          itemBuilder: (context, index) {
            final reservation = state.reservations[index];
            return _ReservationCard(
              key: ValueKey(reservation.id),
              reservation: reservation,
            );
          },
        );
      },
    );
  }

  @override
  AppBar? buildAppBar(
    BuildContext context,
    WidgetRef ref,
    ReservationState? state,
  ) {
    return AppBar(
      backgroundColor: Colors.orange,
      title: Text(
        'RÉSERVATIONS',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      centerTitle: false,
    );
  }

  @override
  Color? buildBackgroundColor(WidgetRef ref, ReservationState? state) {
    return Colors.white;
  }
}

class NewReservationForm extends ConsumerWidget {
  NewReservationForm({super.key, required this.notifier});
  final Refreshable<ReservationNotifier> notifier;

  final _guestsController = TextEditingController();

  Future<void> _selectDate(BuildContext context, WidgetRef ref) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.orange,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      ref.read(notifier).setSelectedDate(picked);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reservationNotifierProvider).value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informations de réservation',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        OreTextField(
          hintText: 'Nombre de personnes',
          controller: state!.seatsController,
          onChanged: (value) {},
          textInputType: TextInputType.number,
        ),
        SizedBox(height: 16),
        InkWell(
          onTap: () => _selectDate(context, ref),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  state?.selectedDate == null
                      ? 'Sélectionner une date'
                      : DateFormat('dd/MM/yyyy').format(state!.selectedDate!),
                  style: TextStyle(
                    color:
                        state?.selectedDate == null
                            ? Colors.grey
                            : Colors.black,
                  ),
                ),
                Icon(Icons.calendar_today, color: Colors.orange),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),

        OreDropdown(
          items:
              state!.tableSlots.map((slot) {
                final startTime = slot['startTime'];
                final endTime = slot['endTime'];
                final formattedTime = '${startTime} - ${endTime}';
                return formattedTime;
              }).toList(),
          onChanged: (String? value) {},
          value:
              '${state.actualSlot['startTime']} - ${state.actualSlot['endTime']}',
          onTap: () {
            ref
                .read(notifier)
                .setActualSlot(
                  state!.tableSlots.where((slot) {
                    final startTime = slot['startTime'];
                    final endTime = slot['endTime'];
                    final formattedTime = '${startTime} - ${endTime}';
                    return formattedTime ==
                        '${state.actualSlot['startTime']} - ${state.actualSlot['endTime']}';
                  }).first,
                );
          },
        ),
        /* InkWell(
          onTap: () => _selectTime(context),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedTime == null
                      ? 'Sélectionner une heure'
                      : _selectedTime!.format(context),
                  style: TextStyle(
                    color: _selectedTime == null ? Colors.grey : Colors.black,
                  ),
                ),
                Icon(Icons.access_time, color: Colors.orange),
              ],
            ),
          ),
        ),*/
        SizedBox(height: 24),
        Center(
          child:
              state.checkingAvailability == true
                  ? CircularProgressIndicator(color: Colors.orange)
                  : OreButton(
                    text: 'Vérifier la disponibilité',
                    onTap: () {
                      ref.read(notifier).checkAvailability();
                    }, //_checkAvailability,
                  ),
        ),
        if (state?.availableTables.isNotEmpty ?? false) ...[
          SizedBox(height: 24),
          Text(
            'Tables disponibles',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ...state!.availableTables.map((table) {
            return Card(
              margin: EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Icon(Icons.table_restaurant, color: Colors.orange),
                title: Text('Table ${table.number}'),
                subtitle: Text('${table.seats} places'),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  onPressed:
                      () => {
                        ref.read(notifier).createReservation(tableId: table.id),
                      },
                  child: Text('Réserver'),
                ),
              ),
            );
          }),
        ],
        if (state?.availableTables.isEmpty ??
            false && state?.checkingAvailability == false) ...[
          SizedBox(height: 24),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.red),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Aucune table disponible pour ce créneau',
                    style: TextStyle(color: Colors.red.shade900),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _ReservationCard extends ConsumerWidget {
  final model.Reservation reservation;

  const _ReservationCard({super.key, required this.reservation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPast = reservation.endDate.isBefore(DateTime.now());
    final isCancelled = reservation.status == model.ReservationStatus.cancelled;

    Color statusColor;
    IconData statusIcon;

    switch (reservation.status) {
      case model.ReservationStatus.pending:
        statusColor = Colors.orange;
        statusIcon = Icons.hourglass_empty;
        break;
      case model.ReservationStatus.confirmed:
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case model.ReservationStatus.cancelled:
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
    }

    return Card(
      margin: EdgeInsets.only(bottom: 16),
      color: Colors.white,
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(statusIcon, color: statusColor, size: 20),
                    SizedBox(width: 8),
                    Text(
                      reservation.statusLabel,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                if (reservation.table != null)
                  Chip(
                    label: Text('Table ${reservation.table!.number}'),
                    backgroundColor: Colors.orange.shade50,
                  ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  DateFormat('dd/MM/yyyy').format(reservation.startDate),
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  '${DateFormat('HH:mm').format(reservation.startDate)} - ${DateFormat('HH:mm').format(reservation.endDate)}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.people, size: 16, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  '${reservation.numberOfGuests} personne(s)',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            if (!isPast && !isCancelled) ...[
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () => _deleteReservation(context, ref),
                    icon: Icon(Icons.edit, color: Colors.grey),
                    label: Text(
                      'Modifier',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => _deleteReservation(context, ref),
                    icon: Icon(Icons.delete, color: Colors.red),
                    label: Text(
                      'Supprimer',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _showCancelDialog(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Annuler la réservation'),
            content: Text('Voulez-vous vraiment annuler cette réservation ?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Non'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Oui', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      try {
        await ref
            .read(reservationNotifierProvider.notifier)
            .cancelReservation(reservation.id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Réservation annulée'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erreur: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Future<void> _deleteReservation(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Supprimer la réservation'),
            content: Text('Voulez-vous vraiment supprimer cette réservation ?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Non'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Oui', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      try {
        await ref
            .read(reservationNotifierProvider.notifier)
            .deleteReservation(reservation.id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Réservation supprimée'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erreur: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
