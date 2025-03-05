// app/page.tsx
import React from 'react';
import About from '../components/About';
import styles from './page.module.css';

export default function HomePage() {
  return (
    <main className={styles.main}>
      <header className={styles.header}>
        <h1>Bienvenue sur mon Portfolio</h1>
        <nav>
          {/* Votre navigation */}
        </nav>
      </header>
      <section>
        <About />
      </section>
    </main>
  );
}
