import OpenAI from 'openai';
import dotenv from 'dotenv';

dotenv.config();

const openAiClient = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

export async function createTripPlan(req, res) {
  try {
    const { startLocation, days, budget, travelStyle, userId } = req.body;

    if (!startLocation || !days || !budget) {
      return res.status(400).json({ message: 'Missing required fields' });
    }

    const prompt = `You are a travel planner for Kerala. Create a ${days}-day itinerary based on the following information:\n` +
      `Start location: ${startLocation}\n` +
      `Travel style: ${travelStyle}\n` +
      `Budget: ₹${budget}\n` +
      `Provide day by day plan with places to visit, recommended restaurants, places to stay, and approximate budgets.`;

    const completion = await openAiClient.responses.create({
      model: 'gpt-4o-mini',
      input: prompt,
      max_tokens: 1024,
      temperature: 0.8,
    });

    const rawText = completion.output_text ?? '';

    const tripPlan = {
      title: `${days}-day Kerala Itinerary`,
      description: rawText.substring(0, 180),
      days,
      budget,
      travelStyle,
      daysPlan: [
        {
          dayNumber: 1,
          summary: rawText,
          stops: [],
        },
      ],
      raw: rawText,
    };

    return res.json({ data: tripPlan });
  } catch (error) {
    return res.status(500).json({ message: 'Unable to generate trip plan', error: error?.message || error });
  }
}

export async function chatAi(req, res) {
  try {
    const { prompt } = req.body;
    if (!prompt) return res.status(400).json({ message: 'Prompt is required' });

    const completion = await openAiClient.responses.create({
      model: 'gpt-4o-mini',
      input: prompt,
      max_tokens: 512,
      temperature: 0.8,
    });

    const rawText = completion.output_text ?? '';
    return res.json({ data: rawText });
  } catch (error) {
    return res.status(500).json({ message: 'Unable to process AI request', error: error?.message || error });
  }
}
