import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/presentation/reservation/state/reservation_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/local/models/reservation.dart';
import '../../../domain/user_logic.dart';
import '../../common/widgets/ore_button.dart';
import '../../common/widgets/ore_textfield.dart';
import '../reservation.dart';
import '../state/reservation_notifier.dart';

class EditReservation extends ConsumerWidget {
  const EditReservation({
    super.key,
    required this.notifier,
    required this.reservation,
  });
  final Refreshable<ReservationNotifier> notifier;
  final Reservation reservation;

  static const route = '/edit-reservation';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reservationNotifierProvider).value!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier la réservation'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              // Text('Modifier ma reservation ${reservation.id}' ),
              const SizedBox(height: 10),
              OreTextField(
                hintText: 'Nombre de personnes',
                controller: state.seatsController,
                onChanged: (value) {},
                textInputType: TextInputType.number,
                initialValue: reservation.numberOfGuests.toString(),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () => _selectDate(context, ref, reservation),
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
                        state.selectedDate == null
                            ? DateFormat(
                              'dd/MM/yyyy',
                            ).format(reservation.startDate)
                            : DateFormat(
                              'dd/MM/yyyy',
                            ).format(state.selectedDate!),
                        style: TextStyle(
                          color:
                               Colors.black,
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
                    state.tableSlots.map((slot) {
                      final startTime = slot['startTime'];
                      final endTime = slot['endTime'];
                      final formattedTime = '${startTime} - ${endTime}';
                      return formattedTime;
                    }).toList(),
                onChanged: (String? value) {
                  final start = value!.split(' - ')[0];
                  final end = value.split(' - ')[1];
                  ref
                      .read(notifier)
                      .setActualSlot(
                        state.tableSlots.where((slot) {
                          final startTime = slot['startTime'];
                          final endTime = slot['endTime'];
                          final formattedTime = '$startTime - $endTime';
                          return formattedTime == '$start - $end';
                        }).first,
                      );
                },
                value:
                    '${state.actualSlot['startTime']} - ${state.actualSlot['endTime']}',
                onTap: () {},
              ),
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
              if (state.availableTables.isNotEmpty ?? false) ...[
                SizedBox(height: 24),
                Text(
                  'Tables disponibles',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                ...state.availableTables.map((table) {
                  return Card(
                    margin: EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: Icon(
                        Icons.table_restaurant,
                        color: Colors.orange,
                      ),
                      title: Text('Table ${table.number}'),
                      subtitle: Text('${table.seats} places'),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          final user = ref.read(userProvider);

                          ref
                              .read(notifier)
                              .updateReservation(tableId: table.id, reservationId: reservation.id);
                        },
                        child: Text('Choisir'),
                      ),
                    ),
                  );
                }),
              ],
              if (state.availableTables.isEmpty && state.hasChecked) ...[
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
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    WidgetRef ref,
    Reservation reservation,
  ) async {
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
}

void openEditReservation({
  required BuildContext context,
  required Reservation reservation,
  required Refreshable<ReservationNotifier> notifier,
}) async {
  await showModalBottomSheet(
    scrollControlDisabledMaxHeightRatio: 0.7,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
      ),
    ),
    builder: (_) {
      return Container(
        height: MediaQuery.sizeOf(context).height * 7,
        padding: const EdgeInsets.only(
          bottom: 16.0,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: EditReservation(reservation: reservation, notifier: notifier),
      );
    },
  );
}
