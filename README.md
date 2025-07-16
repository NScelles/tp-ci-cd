# Spring App

## 🎯 Contexte

Ce projet est une application spring basique ayant pour but de tester la publication d'image docker
---

## Description :

- Développé en Java 21
  
- L'application est composé de :
    * D'une page html 
      * home.html
    * D'un controller HomeController 
       * avec la Route ("/") qui renvoie sur la page home.html
---

## Comment lancer l'application

### 🐋 Docker

```bash
  docker run -d -p 7777:8080 s22001920/docker_exercise_spring
```

## Réalisation de l'exercice 

```bash
    # Création de l'image
    docker build -t docker_exercise_spring .
    
    # Test de l'image
    docker run -d -p 7777:8080 docker_exercise_spring
    
    # Changement du tag:version 
    docker tag docker_exercise_spring s22001920/docker_exercise_spring:v1.0

    # Push de l'image sur docker hub
    docker push s22001920/docker_exercise_spring
```

# 📦 Pipeline CI - GitHub Actions

Ce dépôt contient une pipeline CI (Intégration Continue) définie via GitHub Actions pour compiler, packager, publier et dockeriser une application Java. Cette documentation détaille chaque étape de la pipeline ainsi que son intérêt.

## 🚀 Objectifs de la pipeline

L’objectif principal est d’automatiser l’ensemble du processus de build d’une application Java :
- Compilation et empaquetage du projet (avec Maven)
- Mise en cache des dépendances pour accélérer les workflows
- Génération et publication d’un artefact `.jar`
- Création d’une release GitHub automatique
- Construction et publication de l’image Docker sur Docker Hub

---

## ⚙️ Déclencheur

```yaml
on: workflow_dispatch
```

Le workflow est déclenché **manuellement** depuis l’interface GitHub. Cela permet de contrôler précisément quand la pipeline s’exécute, souvent utile pour des étapes sensibles comme une release ou un déploiement.

---

## 🔍 Détail des étapes

### 1. **Checkout du code**
Permet de récupérer le code source du dépôt GitHub pour exécuter les étapes suivantes sur la dernière version.

### 2. **Installation du JDK**
Configure l’environnement Java avec Oracle JDK 21 pour compiler le projet.

### 3. **Résolution des dépendances**
Télécharge toutes les dépendances Maven via la commande :
```bash
mvn dependency:resolve
```
Cela garantit que les bibliothèques nécessaires sont disponibles localement.

### 4. **Mise en cache des dépendances Maven**
Utilise l’action \`actions/cache\` pour stocker localement les dépendances dans \`~/.m2/repository\`.  
📦 **Avantage :** accélère les exécutions futures en évitant de re-télécharger les mêmes dépendances à chaque exécution.

### 5. **Compilation et empaquetage**
Compile le projet et génère le fichier \`.jar\` avec :
```bash
mvn clean package
```

### 6. **Upload d’un artefact**
Publie l’artefact \`.jar\` généré sous forme d’**artefact GitHub**.  
✅ **Condition :** uniquement sur la branche \`main\` et si toutes les étapes précédentes ont réussi.  
📦 **Pourquoi utiliser des artefacts ?**  
Les artefacts permettent de **conserver une trace des fichiers générés**, indépendamment de l’environnement, pour des fins de test, de déploiement ou de téléchargement manuel.

### 7. **Création d’une release GitHub**
Utilise l’action \`softprops/action-gh-release\` pour publier automatiquement une **release GitHub** contenant le \`.jar\`.

📌 **Pourquoi une release automatique ?**  
- Permet de **versionner** les livrables
- Fournit une interface utilisateur pour télécharger le binaire
- Facilite la traçabilité des versions en production

### 8. **Construction de l’image Docker**
Utilise la commande :
```bash
docker build -t $USERNAME/$REPO_NAME .
```
pour créer une image Docker de l’application.

🐳 **Pourquoi Dockeriser l’application ?**
- Permet d’exécuter l’application dans un environnement standardisé
- Facilite le déploiement sur n’importe quelle plateforme compatible Docker
- Évite les problèmes de compatibilité liés aux dépendances du système

### 9. **Publication sur Docker Hub**
Pousse l’image Docker sur Docker Hub avec :
```bash
docker push $USERNAME/$REPO_NAME
```
---

## 🔐 Sécurité

Les identifiants Docker Hub (\`USERNAME\` et \`PASSWORD\`) sont stockés de manière sécurisée dans les **secrets GitHub**, ce qui évite de les exposer dans le code source.

---

## 📁 Exemple d’arborescence de build

\`\`\`
target/
├── mon-projet.jar       <-- Artefact généré
\`\`\`

---

## 📦 Technologies utilisées

- GitHub Actions
- Java 21 (Oracle)
- Maven
- Docker
- GitHub Releases




