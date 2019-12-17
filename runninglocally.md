# Running Locally

There come times when you want to run your code locally on your machine. While every repo is set up differently, there are a few trends across most repos that you can fall back on. 

Most repos have a `README.md`, which may have the information you're looking for. If the README does not tell you what to do, don't fret! The steps below should work for most repos:

### Golang Repos

If your repo uses Golang, follow these steps:

1. Check if there's a `Makefile` in the repo. If there's no Makefile, do not continue to further steps and instead ask a fellow engineer. 
2. Run `make install_deps`, to install any dependencies. 
3. Run `make generate`, to generate any code based on preset configurations. 
4. Run `make build`, to compile the code. 
5. Run `ark start -l`, to run the build locally. 

### Frontend Repos

Frontend repos tend to follow these steps:

1. `nvm use 12`. This sets your Node version to 12. Replace `12` with the version dictated by the Makefile or README, if it specifies otherwise. 
2. `npm install`, to install dependencies. 
3. `ark start -l` to run locally. 
