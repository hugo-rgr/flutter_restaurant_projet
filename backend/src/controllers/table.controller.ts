import { Request, Response } from 'express';
import tableService from '../services/table.service';

export class TableController {
  // Create a new table
  async createTable(req: Request, res: Response): Promise<void> {
    try {
      const { number, seats } = req.body;

      // Validation
      if (!number || !seats) {
        res.status(400).json({
          error: 'number and seats are required',
        });
        return;
      }

      if (seats < 1) {
        res.status(400).json({
          error: 'seats must be at least 1',
        });
        return;
      }

      const table = await tableService.createTable({
        number: parseInt(number),
        seats: parseInt(seats),
      });

      res.status(201).json(table);
    } catch (error) {
      if (error instanceof Error) {
        if (error.message.includes('already exists')) {
          res.status(409).json({ error: error.message });
          return;
        }
        res.status(400).json({ error: error.message });
      } else {
        res.status(500).json({ error: 'An unknown error occurred' });
      }
    }
  }

  // Get all tables
  async getAllTables(req: Request, res: Response): Promise<void> {
    try {
      const tables = await tableService.getAllTables();
      res.status(200).json(tables);
    } catch (error) {
      if (error instanceof Error) {
        res.status(500).json({ error: error.message });
      } else {
        res.status(500).json({ error: 'An unknown error occurred' });
      }
    }
  }

  // Get a single table
  async getTableById(req: Request, res: Response): Promise<void> {
    try {
      const { id } = req.params;
      const table = await tableService.getTableById(parseInt(id));
      res.status(200).json(table);
    } catch (error) {
      if (error instanceof Error) {
        if (error.message === 'Table not found') {
          res.status(404).json({ error: error.message });
          return;
        }
        res.status(500).json({ error: error.message });
      } else {
        res.status(500).json({ error: 'An unknown error occurred' });
      }
    }
  }

  // Update a table
  async updateTable(req: Request, res: Response): Promise<void> {
    try {
      const { id } = req.params;
      const { number, seats } = req.body;

      const data: any = {};
      if (number) data.number = parseInt(number);
      if (seats) {
        const seatsNum = parseInt(seats);
        if (seatsNum < 1) {
          res.status(400).json({
            error: 'seats must be at least 1',
          });
          return;
        }
        data.seats = seatsNum;
      }

      const table = await tableService.updateTable(parseInt(id), data);
      res.status(200).json(table);
    } catch (error) {
      if (error instanceof Error) {
        if (error.message === 'Table not found') {
          res.status(404).json({ error: error.message });
          return;
        }
        if (error.message.includes('already exists') ||
            error.message.includes('Cannot reduce seats')) {
          res.status(409).json({ error: error.message });
          return;
        }
        res.status(400).json({ error: error.message });
      } else {
        res.status(500).json({ error: 'An unknown error occurred' });
      }
    }
  }

  // Delete a table
  async deleteTable(req: Request, res: Response): Promise<void> {
    try {
      const { id } = req.params;
      const result = await tableService.deleteTable(parseInt(id));
      res.status(200).json(result);
    } catch (error) {
      if (error instanceof Error) {
        if (error.message === 'Table not found') {
          res.status(404).json({ error: error.message });
          return;
        }
        if (error.message.includes('Cannot delete table')) {
          res.status(409).json({ error: error.message });
          return;
        }
        res.status(400).json({ error: error.message });
      } else {
        res.status(500).json({ error: 'An unknown error occurred' });
      }
    }
  }

  // Get table statistics
  async getTableStatistics(req: Request, res: Response): Promise<void> {
    try {
      const { id } = req.params;
      const stats = await tableService.getTableStatistics(parseInt(id));
      res.status(200).json(stats);
    } catch (error) {
      if (error instanceof Error) {
        if (error.message === 'Table not found') {
          res.status(404).json({ error: error.message });
          return;
        }
        res.status(500).json({ error: error.message });
      } else {
        res.status(500).json({ error: 'An unknown error occurred' });
      }
    }
  }
}

export default new TableController();
