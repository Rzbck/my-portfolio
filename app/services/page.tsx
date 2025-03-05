// app/services/page.tsx
import Link from 'next/link';
import styles from '../page.module.css';

export default function ServicesPage() {
  return (
    <main className={styles.main}>
      <header className={styles.header}>
        <h1>Mes Services</h1>
        <nav>
          <Link href="/">Accueil</Link> |{' '}
          <Link href="/contact">Contact</Link>
        </nav>
      </header>
      <section>
        <h2>Services</h2>
        <p>Décrivez ici vos services : scénographie interactive, audiovisuel, développement d'applications, etc.</p>
      </section>
    </main>
  );
}
