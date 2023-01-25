import eventsRepository from "@/repositories/eventsRepository";

async function getAllEvents() {
  const events = await eventsRepository.findEvents();

  return events;
}

const eventsService = {
  getAllEvents,
};

export default eventsService;
