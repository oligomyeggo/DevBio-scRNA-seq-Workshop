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
None! While this is not an inclusive introduction to Python/R course, and while we will be covering a lot of material fast, we believe that anyone can learn to do their own scRNA-seq analysis and want to make bioinformatics as accessible (and fun!) as possible. To that end, we have provided both a Python and R tutorial (check out the files in `workspace/intro_to_programming`) to help you quickly get up to speed with some programming basics. Will completing these tutorials make you an expert? No, but they will help you get a feel for programming in both Python and R and help you take your first steps towards becoming a bioinformatics wizard!

## Installation Instructions
While not strictly required for this workshop, we highly recommend installing and using git and GitHub for this workshop and future analyses projects you might undertake. Git is a great way to collaborate on analysis projects, and hosting your analysis workflows on GitHub that accompany publications is tremendously helpful to the field.

Docker **is** required for this workshop, as we have compiled everything you'll need into an easy-to-use docker container. Docker is also great to get in the habit of using, as it can help ensure your code is reproducible.
### Git and GitHub
Check out instructions [here](https://github.com/git-guides/install-git) to install git on both Mac and Windows machines.
### Docker
Check out instructions [here](https://docs.docker.com/engine/install/) to install docker on both Mac and Windows machine. *If you are a Windows user, please note that you will also need to install Windows Subsystem for Linux (WSL) 2. You can find more info [here](https://docs.docker.com/desktop/windows/wsl/).*
### Set Up
Once git and docker are installed on your computer, follow these steps to get the workshop docker container up and running!
1. The very first thing you need to do is change how much memory is allocated to docker on your computer. The default memory allocation is 2 GB, which is not enough for some of the more memory-intensive computational steps in our analysis pipeline.
    * **For Mac users**: Open up your docker desktop dashboard GUI. Click the gear icon in the upper righthand corner of the dashboard. Click the *Resources* tab, then set *Memory* to be 4 GB. You should not need to change any of the other parameters. Click the *Apply & Restart* button at the bottom of the dashboard. That's it!
    * **For Windows users**: Using the command prompt, navigate to your home directory (by default your should be in your home directory when opening a new command prompt window). Create a new `.wslconfig` file in your home directory. Edit the new `.wslconfig` file to look like this:
        ```bash
        [wsl2]
        memory=4GB
        swap=0
        localhostForwarding=true
        ```
        Save this file and you're good to go!
2. Next, on this GitHub page, click the green *Code* button at the top of the screen and copy the SSH link. 
    * *Note: if you decided **not** to install git, under the green* Code *button you can hit* Download Zip *and download the workshop repo to wherever you want it on your computer. Skip steps 3 and 4 and proceed with step 5.*
3. In your terminal (for Mac users; command prompt for Windows users), navigate to the folder where you want to clone this repo (maybe a *workshop* folder on your Desktop, for instance).
4. Once in your desired folder, type: `git clone git@github.com:oligomyeggo/DevBio-scRNA-seq-Workshop.git` and hit enter. You should now see all of the contents of the GitHub repo in your folder.
5. Now navigate into the *DevBio-scRNA-seq-Workshop* folder and type: `docker compose up --build` and hit enter. This will build your docker container. The initial build takes some time, ~2 hours. **It will only take this long the first time!** After the initial build, you will be able to exit the container and reboot it in a matter of seconds. *Note that if you decide to change the Dockerfile in any way, or if we change the Dockerfile and you pull those changes, you will have to rebuild the container. We have also noticed that sometimes after an operating systems update rebuilding the container is required. Rebuilding the container generally takes just as long as doing the initial build.*

## Using the Container
Once your containter is built, you will notice a couple different urls available in your terminal. Go ahead and copy the last url address and paste it into your browser of choice. Hit enter. You should now see a Jupyter Labs interface. Congratulations! You're ready to rock and code!

* To shut down the container: in your terminal window where the container is running, simply hit `ctrl+c`.
* To reboot the container: in your terminal in the *DevBio-scRNA-seq-Workshop* folder, run `docker compose up`.

Our docker set-up includes volumes in order to store files on your local machine. This means that files are persisted even after the container stops. In other words, if you are working on a data analysis in this container you can save your progress and resume your analysis at a later point. You can also access all the files in your container via your computer's file manager (i.e, Finder on Mac and File Explorer on Windows).

## Other Coding Resources
If you want additional coding practice (and who doesn't?! It's fun and we can only cover so much in our workshop!), we recommend the following websites and free online courses:
* [exercism.org](https://exercism.org/dashboard): an awesome open-source and not-for-profit website where you solve coding exercises and get mentored to gain true fluency in your chosen programming language(s) (they currently support 55 different programming languages, including Python and R). Highly recommended!
* Free online courses from Udemy:
    * [Introduction to Python Programming](https://www.udemy.com/course/pythonforbeginnersintro/): covers Python basics and essentials.
    * [Python for Absolute Beginners!](https://www.udemy.com/course/free-python/): covers Python basics, including how to write functions and arguments.
    * [R Basics - R Programming Language Introduction](https://www.udemy.com/course/r-basics/): covers the basics of using RStudio, making graphs, handling packages, and performing basic commands.
    * [R, ggplot, and Simple Linear Regression](https://www.udemy.com/course/machlearn1/): covers vectors and data frames in R, and how to use the `ggplot` package.