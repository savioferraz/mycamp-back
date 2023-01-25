import express, { Express } from "express";
import { loadEnv } from "./config/envs";
import { connectDb, disconnectDb } from "./db/db";
import cors from "cors";
import { eventsRouter } from "./routers";

loadEnv();

const app = express();

app.use(cors()).use(express.json()).use("/events", eventsRouter);

export async function init(): Promise<Express> {
  connectDb();
  return Promise.resolve(app);
}

export async function close() {
  await disconnectDb();
}

export default app;
