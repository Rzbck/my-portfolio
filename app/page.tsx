// app/page.tsx
import Link from 'next/link';
import styles from './page.module.css';

export default function HomePage() {
  return (
    <main className={styles.main}>
      <header className={styles.header}>
        <h1>Bienvenue sur mon Portfolio</h1>
        <p>Découvrez mes compétences et mes services</p>
        <nav>
          <Link href="/services">Services</Link> |{' '}
          <Link href="/contact">Contact</Link>
        </nav>
      </header>
      <section>
        <h2>Accueil</h2>
        <p>Ici, vous pouvez présenter un aperçu de vos projets et de votre expertise.</p>
      </section>
    </main>
  );
}
