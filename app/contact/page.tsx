// app/contact/page.tsx
import Link from 'next/link';
import ContactForm from '../../components/ContactForm';
import styles from '../page.module.css';

export default function ContactPage() {
  return (
    <main className={styles.main}>
      <header className={styles.header}>
        <h1>Contactez-moi</h1>
        <nav>
          <Link href="/">Accueil</Link> |{' '}
          <Link href="/services">Services</Link>
        </nav>
      </header>
      <section>
        <ContactForm />
      </section>
    </main>
  );
}
