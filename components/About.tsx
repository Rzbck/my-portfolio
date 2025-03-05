import React from 'react';
import styles from './About.module.css';

export default function About() {
  return (
    <section className={styles.about}>
      <h1>Charlelie Chauvel - Portfolio</h1>
      <p>
        Bienvenue sur mon portfolio ! Je suis Charlelie Chauvel, couteau suisse chez Hardwinner, expert en scénographie interactive et design audiovisuel. Avec plus de 18 ans d'expérience, je fusionne l’art, la technologie et l’interactivité pour créer des expériences immersives inoubliables.
      </p>
      
      <h2>Compétences Clés</h2>
      <ul>
        <li>Scénographie interactive & design audiovisuel  
          (Lighting, Video Mapping, Projection Mapping, Intégration Spout)</li>
        <li>Programmation créative (Python, GLSL, API REST, Git)</li>
        <li>Production Média & Art Numérique (vidéo, photographie, streaming, direction artistique)</li>
        <li>Gestion d’événements & projets immersifs (planification, team building, relations publiques)</li>
        <li>Développement d’applications rapides & IA Prompting (ChatGPT, Claude)</li>
      </ul>
      
      <h2>Services Proposés</h2>
      <p>
        Je propose des solutions sur mesure pour donner vie à vos projets :
      </p>
      <ul>
        <li>Conception et réalisation de scénographies interactives en live</li>
        <li>Création de contenus audiovisuels innovants</li>
        <li>Développement d'applications digitales et automatisation des workflows</li>
        <li>Gestion complète d’événements et performances immersives</li>
      </ul>
      
      <h2>Contactez-moi</h2>
      <p>
        Pour toute demande de collaboration ou information, n’hésitez pas à me contacter :
      </p>
      <ul>
        <li>Email : <a href="mailto:cworksw@gmail.com">cworksw@gmail.com</a></li>
        <li>
          LinkedIn : <a href="https://www.linkedin.com/in/charlelie-chauvel-08a89038/" target="_blank" rel="noopener noreferrer">Charlelie Chauvel</a>
        </li>
        <li>
          Instagram : <a href="https://www.instagram.com/data_c0re_/" target="_blank" rel="noopener noreferrer">data_c0re_</a>
        </li>
      </ul>
      <p>
        Parcourez mes projets et réalisations pour découvrir comment je peux donner vie à vos idées.
      </p>
    </section>
  );
}
