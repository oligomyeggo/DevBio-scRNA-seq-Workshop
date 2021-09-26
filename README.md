# Dev Bio scRNA-seq Workshop <img src="img/devbioscrnaseqworkshoplogo_hex.png" align="right" width=200>

Welcome to the Section of Developmental Biology single cell RNA-sequencing workshop GitHub page! Here you will find all the code needed for the workshop.

## Workshop Description
In this workshop you will learn how to analyze single cell RNA-sequencing data produced by popular upstream processing pipelines (like the Chromium 10x platform Cell Ranger) using Python and R. This will include reading  data into either a Python or R coding environment, preprocessing the data (filtering cells, normalization, feature selection, and dimensionality reduction), clustering and cell type annotation, and pseudotime/trajectory inference analysis.

## Workshop Goals
This workshop is a crash course in scRNA-seq analysis. It was designed to give you a sense for the general steps and processes involved in analyzing scRNA-seq data, and provide an overview for good analysis practices. We do not expect you to leave this workshop as a bioinformatics expert (it takes years to become an expert on anything!). Rather, this workshop should serve as an introduction that gives you the toolkits and confidence you need to start doing your own analysis. While you may not remember the exact snippets of code you need at each step (which is totally fine! Bioinformaticians don't have everything memorized either. Google is your friend), we hope you will leave our workshop with a basic understanding and appreciation for:
* Python and R programming essentials
* scRNA-seq analysis principles and concepts
* scRNA-seq best practices

We also hope you will leave our workshop with some ideas on how to analyze your own data!

## Prerequisites
None! While this is not an inclusive introduction to Python/R course, and while we will be covering a lot of material fast, we believe that anyone can learn to do their own scRNA-seq analysis and want to make bioinformatics as accessible (and fun!) as possible. To that end, we have provided both an *Intro to Python* and an *Intro to R* tutorial to help you quickly get up to speed with some programming basics. Will completing these tutorials make you an expert? No, but they will help you get a feel for programming in both Python and R and help you take your first steps towards becoming a bioinformatics wizard!

## Installation Instructions
While not strictly required for this workshop, we highly recommend installing and using Git and GitHub for this workshop and future analyses projects you might undertake. Git is a great way to collaborate on analysis projects, and hosting your analysis workflows on GitHub that accompany publications is tremendously helpful to the field.

Docker **is** required for this workshop, as we have compiled everything you'll need into an easy-to-use Docker container. Docker is also great to get in the habit of using, as it can help ensure your code is reproducible.
### Git and GitHub
Check out instructions [here](https://github.com/git-guides/install-git) to install Git on both Mac and Windows machines.
### Docker
Check out instructions [here](https://docs.docker.com/engine/install/) to install Docker on both Mac and Windows machine. *If you are a Windows user, please note that you will also need to install Windows Subsystem for Linux (WSL) 2. You can find more info [here](https://docs.docker.com/desktop/windows/wsl/).*
### Set Up
Once Git and Docker are installed on your computer, follow these steps to get the workshop Docker container up and running!
1. On this page, click the green *Code* button at the top of the screen and copy the SSH link.
2. In your terminal (for Mac users; command prompt for Windows users), navigate to the folder where you want to clone this repo (maybe a *workshop* folder on your Desktop, for instance).
3. Once in your desired folder, type: `git clone git@github.com:oligomyeggo/DevBio-scRNA-seq-Workshop.git` and hit enter. You should now see all of the contents of the GitHub repo in your folder.
4. Now navigated into the *DevBio-scRNA-seq-Workshop* folder and type: `docker compose up --build` and hit enter. This will build your Docker container. The initial build takes some time, ~2 hours. **It will only take this long the first time!** After the initial build, you will be able to exit the container and reboot it in a matter of seconds. *Note that if you decide to change the Dockerfile in any way, or if we change the Dockerfile and you pull those changes, you will have to go through a long, initial build step again.*