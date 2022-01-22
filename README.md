# Organizer

### Requirements

- ruby 2.7.5p203
- bundler 2.1.4
- sqlite3 3.31.1
- nodejs >= 4.18.3

### Setup
###### * Ubuntu & rbenv

create `.env` file and copy the `.env.example` content into it

clone the repository and go to the organizer folder:
```bash
git clone git@github.com:AronnaxSpace/organizer.git
cd organizer
```

install ruby:
```bash
rbenv install 2.7.5
```

install nodejs and npm:
```bash
sudo apt update
sudo apt install nodejs npm
```

install sqlite3 and libsqlite3-dev
```bash
sudo apt install sqlite3 libsqlite3-dev
```

install bundler:
```bash
gem install bundler
```

install ruby dependencies:
```bash
bundle install
```

install js dependencies:
```bash
npm install
```

set database:
```bash
rake db:setup
```

### Run application

run these commands in 2 parallel terminal sessions:
```bash
shotgun
npm run dev
```
