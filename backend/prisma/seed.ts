import { PrismaClient, UserRole, ReservationStatus } from '@prisma/client';
import * as bcrypt from 'bcrypt';

const prisma = new PrismaClient();

async function main() {
  console.log('🌱 Starting seed...');

  // Créer des utilisateurs
  const hashedPassword = await bcrypt.hash('password123', 10);

  const admin = await prisma.user.create({
    data: {
      email: 'admin@restaurant.com',
      name: 'Admin User',
      password: hashedPassword,
      phone: '+33123456789',
      role: UserRole.admin,
    },
  });
  console.log('✅ Admin créé');

  const hote = await prisma.user.create({
    data: {
      email: 'hote@restaurant.com',
      name: 'Hôte Restaurant',
      password: hashedPassword,
      phone: '+33123456788',
      role: UserRole.hote,
    },
  });
  console.log('✅ Hôte créé');

  const clients = await Promise.all([
    prisma.user.create({
      data: {
        email: 'marie.dupont@example.com',
        name: 'Marie Dupont',
        password: hashedPassword,
        phone: '+33612345678',
        role: UserRole.client,
      },
    }),
    prisma.user.create({
      data: {
        email: 'jean.martin@example.com',
        name: 'Jean Martin',
        password: hashedPassword,
        phone: '+33612345679',
        role: UserRole.client,
      },
    }),
    prisma.user.create({
      data: {
        email: 'sophie.bernard@example.com',
        name: 'Sophie Bernard',
        password: hashedPassword,
        phone: '+33612345680',
        role: UserRole.client,
      },
    }),
    prisma.user.create({
      data: {
        email: 'pierre.dubois@example.com',
        name: 'Pierre Dubois',
        password: hashedPassword,
        phone: '+33612345681',
        role: UserRole.client,
      },
    }),
  ]);
  console.log('✅ Clients créés');

  // Créer des tables
  const tables = await Promise.all([
    prisma.table.create({
      data: {
        number: 1,
        seats: 2,
        timeSlot: [
          { startTime: '12:00', endTime: '14:00' },
          { startTime: '19:00', endTime: '22:00' },
        ],
      },
    }),
    prisma.table.create({
      data: {
        number: 2,
        seats: 4,
        timeSlot: [
          { startTime: '12:00', endTime: '14:00' },
          { startTime: '19:00', endTime: '22:00' },
        ],
      },
    }),
    prisma.table.create({
      data: {
        number: 3,
        seats: 4,
        timeSlot: [
          { startTime: '12:00', endTime: '14:00' },
          { startTime: '19:00', endTime: '22:00' },
        ],
      },
    }),
    prisma.table.create({
      data: {
        number: 4,
        seats: 6,
        timeSlot: [
          { startTime: '12:00', endTime: '14:00' },
          { startTime: '19:00', endTime: '22:00' },
        ],
      },
    }),
    prisma.table.create({
      data: {
        number: 5,
        seats: 8,
        timeSlot: [
          { startTime: '12:00', endTime: '14:00' },
          { startTime: '19:00', endTime: '22:00' },
        ],
      },
    }),
    prisma.table.create({
      data: {
        number: 6,
        seats: 2,
        timeSlot: [
          { startTime: '12:00', endTime: '14:00' },
          { startTime: '19:00', endTime: '22:00' },
        ],
      },
    }),
  ]);
  console.log('✅ Tables créées');

  // Créer des réservations
  const today = new Date();
  const tomorrow = new Date(today);
  tomorrow.setDate(tomorrow.getDate() + 1);
  const inTwoDays = new Date(today);
  inTwoDays.setDate(inTwoDays.getDate() + 2);

  await prisma.reservation.create({
    data: {
      userId: clients[0].id,
      tableId: tables[0].id,
      timeSlotId: '3',
      numberOfGuests: 2,
      startDate: new Date(tomorrow.setHours(12, 0, 0, 0)),
      endDate: new Date(tomorrow.setHours(14, 0, 0, 0)),
      status: ReservationStatus.confirmed,
    },
  });

  await prisma.reservation.create({
    data: {
      userId: clients[1].id,
      tableId: tables[1].id,
      timeSlotId: '6',
      numberOfGuests: 4,
      startDate: new Date(tomorrow.setHours(19, 0, 0, 0)),
      endDate: new Date(tomorrow.setHours(21, 0, 0, 0)),
      status: ReservationStatus.confirmed,
    },
  });

  await prisma.reservation.create({
    data: {
      userId: clients[2].id,
      tableId: tables[3].id,
      timeSlotId: '6',
      numberOfGuests: 6,
      startDate: new Date(inTwoDays.setHours(19, 30, 0, 0)),
      endDate: new Date(inTwoDays.setHours(22, 0, 0, 0)),
      status: ReservationStatus.pending,
    },
  });

  await prisma.reservation.create({
    data: {
      userId: clients[3].id,
      tableId: tables[2].id,
      timeSlotId: '3',
      numberOfGuests: 3,
      startDate: new Date(inTwoDays.setHours(12, 30, 0, 0)),
      endDate: new Date(inTwoDays.setHours(14, 0, 0, 0)),
      status: ReservationStatus.pending,
    },
  });

  console.log('✅ Réservations créées');
  console.log('\n🎉 Seed terminé avec succès!');
  console.log('\n📊 Résumé:');
  console.log(`   - ${1} Admin (email: admin@restaurant.com)`);
  console.log(`   - ${1} Hôte (email: hote@restaurant.com)`);
  console.log(`   - ${clients.length} Clients`);
  console.log(`   - ${tables.length} Tables`);
  console.log(`   - ${4} Réservations`);
  console.log('\n🔑 Mot de passe pour tous les utilisateurs: password123');
}

main()
  .catch((e) => {
    console.error('❌ Erreur lors du seed:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
