import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/presentation/reservation/widgets/reservation_form.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_restaurant_app/data/local/models/reservation.dart'
    as model;
import 'package:intl/intl.dart';

import '../state/reservation_notifier.dart';
import '../state/reservation_state.dart';
import 'edit_reservation.dart';

class ReservationCard extends ConsumerWidget {
  final model.Reservation reservation;
  final bool isAdmin;
  final Refreshable<ReservationNotifier> notifier;
  final ReservationState state;

  const ReservationCard({
    super.key,
    required this.reservation,
    required this.state,
    required this.notifier,
    this.isAdmin = false,
  });

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
      case model.ReservationStatus.rejected:
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
                  if (reservation.status == model.ReservationStatus.pending)
                    TextButton.icon(
                      onPressed: () async {
                        if (isAdmin) {
                          ref
                              .read(notifier)
                              .acceptOrRefuseReservation(
                                id: reservation.id,
                                accept: true,
                              );
                        } else {


                          ref.read(notifier).addSlot(reservation, notifier);


                        }
                      },
                      icon: Icon(
                        isAdmin ? Icons.done : Icons.edit,
                        color: Colors.grey,
                      ),
                      label: Text(
                        isAdmin ? 'Confirmer' : 'Modifier',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  if (reservation.status == model.ReservationStatus.pending)
                    TextButton.icon(
                    onPressed: () {
                      if (isAdmin) {
                        ref
                            .read(notifier)
                            .acceptOrRefuseReservation(
                              id: reservation.id,
                              accept: false,
                            );
                      } else {
                        _deleteReservation(context, ref);
                      }
                    },
                    icon: Icon(
                      isAdmin ? Icons.close : Icons.delete,
                      color: Colors.red,
                    ),
                    label: Text(
                      isAdmin ? 'Rejeter' : 'Supprimer',
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
