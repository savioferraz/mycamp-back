import eventsService from "@/services/eventsService";
import { Request, Response } from "express";

export async function getAllEvents(_req: Request, res: Response) {
  try {
    const events = await eventsService.getAllEvents();
    return res.status(200).send(events);
  } catch (error) {
    return res.status(400).send({});
  }
}
