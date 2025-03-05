// pages/api/contact.ts
import type { NextApiRequest, NextApiResponse } from 'next';

type Data = { message: string };

export default function handler(req: NextApiRequest, res: NextApiResponse<Data>) {
  if (req.method !== 'POST') {
    return res.status(405).json({ message: 'Méthode non autorisée' });
  }

  const { name, email, message } = req.body;

  if (!name || !email || !message) {
    return res.status(400).json({ message: 'Champs requis manquants.' });
  }

  // Ici, vous pouvez ajouter la logique d'envoi d'e-mail ou d'enregistrement dans une BDD.
  return res.status(200).json({ message: 'Formulaire reçu. Nous vous contacterons bientôt !' });
}
