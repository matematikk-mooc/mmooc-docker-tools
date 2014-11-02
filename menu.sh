#! /bin/bash

echo "*:*:*:*:$DBPASS" > ~/.pgpass
chmod 0600 ~/.pgpass

export PGUSER="canvas"
export PGHOST=$DB_PORT_5432_TCP_ADDR
export PGPORT=$DB_PORT_5432_TCP_PORT

while true; do
    cmd=(dialog --keep-tite --menu "Select options:" 22 76 16)

    options=(1 "Error reports"
             2 "Option 2"
             3 "Psql"
             4 "Option 4")

    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

    for choice in $choices
    do
        case $choice in
            1)
                echo '\x on \\ SELECT message, backtrace FROM error_reports ORDER BY id DESC' | psql canvas_production
                echo "Press a key"
                read
                ;;
            2)
                echo "Second Option"
                ;;
            3)
                psql canvas_production
                ;;
            4)
                echo "Fourth Option"
                ;;
        esac
    done
done
     
