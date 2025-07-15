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





