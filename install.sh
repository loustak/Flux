ask() {
    # https://djm.me/ask
    local prompt default reply

    while true; do

        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "$1 [$prompt] "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read reply </dev/tty

        # Default?
        if [ -z "$reply" ]; then
            reply=$default
        fi

        # Check if the reply is valid
        case "$reply" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}

# Add Erlang solutions to available repo
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb
sudo apt-get update
# Install Erlang
sudo apt-get install esl-erlang
# Install Elixir
sudo apt-get install elixir


# Install postgre sql
sudo apt-get install postgresql postgresql-contrib
# Connect as the default postgres user to change the password
sudo passwd postgres
# Utilise l'utilisateur postgres pour changer le mot de passe dans la base de données
sudo -u postgres psql -c psql -d template1 -c "ALTER USER postgres WITH PASSWORD 'postgres';"


sudo service postgresql start
