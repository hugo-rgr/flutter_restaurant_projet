import swaggerJsdoc from 'swagger-jsdoc';

const options: swaggerJsdoc.Options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'Restaurant Reservation API',
      version: '1.0.0',
      description: 'API REST pour la gestion des réservations de restaurant',
      contact: {
        name: 'API Support',
        email: 'support@restaurant.com',
      },
    },
    servers: [
      {
        url: process.env.API_URL || 'http://localhost:3000',
        description: 'Serveur de développement',
      },
    ],
    components: {
      securitySchemes: {
        bearerAuth: {
          type: 'http',
          scheme: 'bearer',
          bearerFormat: 'JWT',
          description: 'Entrez votre token JWT',
        },
      },
      schemas: {
        User: {
          type: 'object',
          properties: {
            id: {
              type: 'string',
              description: 'ID unique de l\'utilisateur',
            },
            email: {
              type: 'string',
              format: 'email',
              description: 'Email de l\'utilisateur',
            },
            name: {
              type: 'string',
              description: 'Nom de l\'utilisateur',
            },
            role: {
              type: 'string',
              enum: ['client', 'hote', 'admin'],
              description: 'Rôle de l\'utilisateur',
            },
          },
        },
        Reservation: {
          type: 'object',
          properties: {
            id: {
              type: 'string',
              description: 'ID unique de la réservation',
            },
            userId: {
              type: 'string',
              description: 'ID de l\'utilisateur',
            },
            tableId: {
              type: 'string',
              description: 'ID de la table',
            },
            date: {
              type: 'string',
              format: 'date-time',
              description: 'Date et heure de la réservation',
            },
            numberOfGuests: {
              type: 'integer',
              minimum: 1,
              description: 'Nombre de personnes',
            },
            status: {
              type: 'string',
              enum: ['pending', 'confirmed', 'cancelled', 'completed'],
              description: 'Statut de la réservation',
            },
            specialRequests: {
              type: 'string',
              description: 'Demandes spéciales',
            },
          },
        },
        Table: {
          type: 'object',
          properties: {
            id: {
              type: 'string',
              description: 'ID unique de la table',
            },
            tableNumber: {
              type: 'integer',
              description: 'Numéro de la table',
            },
            capacity: {
              type: 'integer',
              description: 'Capacité de la table',
            },
            location: {
              type: 'string',
              description: 'Emplacement de la table (terrasse, intérieur, etc.)',
            },
            isAvailable: {
              type: 'boolean',
              description: 'Disponibilité de la table',
            },
          },
        },
        Error: {
          type: 'object',
          properties: {
            error: {
              type: 'string',
              description: 'Message d\'erreur',
            },
          },
        },
        Success: {
          type: 'object',
          properties: {
            message: {
              type: 'string',
              description: 'Message de succès',
            },
          },
        },
      },
    },
    security: [],
  },
  apis: ['./src/routes/*.ts'], // Chemin vers les fichiers de routes
};

export const swaggerSpec = swaggerJsdoc(options);
