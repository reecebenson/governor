#!/bin/bash
# Bash script to setup the basic configuration for the bot

# ANSI colors
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
BLUE='\033[0;36m'
NC='\033[0m'

echo -e "${YELLOW}This is a script to quickly install and setup your new Governor bot.${NC}";

# This script assumes this is a Debian-based server with apt
if ! [ -x "$(command -v apt)" ]; then
    echo -e "${RED}This script only works on Debian based servers.${NC}";
    exit 1;
fi

# Install packages
echo -e "${BLUE}Installing necessary packages${NC}";
sudo apt update;
sudo apt install python3 python3-pip python3-virtualenv sqlite3 php7.3 php7.3-sqlite3 php7.3-json;

# Setup Python
echo -e "${BLUE}Setting up Python virtual environment and libaries${NC}";
python3 -m virtualenv --no-site-packages .;
source bin/activate;
python3 -m pip install -r requirements.txt;

# Make default configuration files
echo -e "${BLUE}Generating default configuration files${NC}";
mkdir -p src/private;
cat << EOF > src/private/config.json
{
    "discord": "YOUR DISCORD TOKEN HERE",
    "debug": "False",
    "db_path": "private/database.db",
    "ranks_path": "private/ranks.json",
    "command_prefix": "!",
    "owner": 0,
    "roles": {
        "admin_access": 0
    },
    "server_url": "https://example.com",
    "games": {
        "announcement_channel": 0,
        "announcement_time": "12:00 AM"
    },
    "channels": {
        "lvl_allowed": [],
        "slowmode_disabled": [],
        "xp_disabled": []
    }
}
EOF

cat << EOF > src/private/ranks.json
{
    "ranks": [
        {
            "name": "Rank Name",
            "level": 1,
            "message": "This is the message that will be posted when a user earns this rank",
            "role_id": 0
        }
    ]
}
EOF

echo -e "${BLUE}"
echo "Setup complete! The bot can be run by running:";
echo -e "${GREEN}"
echo "source bin/activate";
echo "cd src";
echo "python3 main.py";
echo "";
echo -e "${RED}"
echo "Things you still need to do:"
echo -e "${NC}"
echo "Get a Discord bot token if you haven't yet"
echo "Go to 'https://discord.com/developers/applications' and make a new app."
echo "Go to 'Bot' on the sidebar, and Add bot."
echo "Copy the Token and go into private/config.json with your favorite text editor, and paste that in place of 'YOUR DISCORD TOKEN HERE'."
echo "Replace some of the other settings to your preferences as well (particularly the ones set to '0')."
echo -e "${BLUE}If you have a webserver, make a symlink to the file path of where you want the leaderboard page to be:";
echo -e "${GREEN}ln -s path/to/governor/src/web path/to/webserver";
echo -e "${NC}"
