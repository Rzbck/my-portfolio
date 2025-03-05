// components/ContactForm.tsx
'use client';

import React, { useState } from 'react';
import styles from './ContactForm.module.css';

export default function ContactForm() {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    phone: '',
    message: ''
  });
  const [status, setStatus] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setStatus(null);

    try {
      const response = await fetch('/api/contact', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData),
      });

      if (response.ok) {
        setStatus("Merci, votre message a bien été envoyé !");
        setFormData({ name: '', email: '', phone: '', message: '' });
      } else {
        setStatus("Erreur lors de l'envoi, réessayez plus tard.");
      }
    } catch (error) {
      console.error(error);
      setStatus("Erreur lors de l'envoi, réessayez plus tard.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className={styles.formContainer}>
      <div className={styles.formGroup}>
        <label htmlFor="name">Nom :</label>
        <input type="text" id="name" name="name" required value={formData.name} onChange={handleChange} />
      </div>
      <div className={styles.formGroup}>
        <label htmlFor="email">Email :</label>
        <input type="email" id="email" name="email" required value={formData.email} onChange={handleChange} />
      </div>
      <div className={styles.formGroup}>
        <label htmlFor="phone">Téléphone (optionnel) :</label>
        <input type="text" id="phone" name="phone" value={formData.phone} onChange={handleChange} />
      </div>
      <div className={styles.formGroup}>
        <label htmlFor="message">Message :</label>
        <textarea id="message" name="message" required rows={4} value={formData.message} onChange={handleChange} />
      </div>
      <button type="submit" disabled={loading}>
        {loading ? 'Envoi en cours...' : 'Envoyer'}
      </button>
      {status && <p className={styles.statusMessage}>{status}</p>}
    </form>
  );
}
