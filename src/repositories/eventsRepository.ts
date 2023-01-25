import { prisma } from "@/db/db";

async function findEvents() {
  return prisma.events.findMany();
}

const eventsRepository = {
  findEvents,
};

export default eventsRepository;
