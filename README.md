# Organizer

### Requirements

- ruby 2.7.5p203
- bundler 2.1.4
- sqlite3 3.31.1
- nodejs => 4.18.3

### Setup (Ubuntu, rbenv)

clone the repository and go to the organizer folder:
```bash
git clone git@github.com:AronnaxSpace/organizer.git
cd organizer
```

install the required version of ruby:
```bash
rbenv install 2.7.5
```

install nodejs and npm:
```bash
sudo apt install nodejs
sudo apt install npm
```

install sqlite3 and libsqlite3-dev
```bash
sudo apt update && sudo apt upgrade
sudo apt install sqlite3 libsqlite3-dev
```

install bundler and install dependencies:
```bash
gem install bundler
bundle install
```

install js dependencies:
```bash
npm install
```

### Run application

run 2 commands in parallel terminal sessions:
```bash
shotgun
npm run dev
```
