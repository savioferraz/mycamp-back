import { getAllEvents } from "@/controllers";
import { Router } from "express";

const eventsRouter = Router();

eventsRouter.get("/", getAllEvents);

export { eventsRouter };
