#! /bin/bash

echo "*:*:*:*:$DBPASS" > ~/.pgpass
chmod 0600 ~/.pgpass

export PGUSER="canvas"
export PGHOST=$DB_PORT_5432_TCP_ADDR
export PGPORT=$DB_PORT_5432_TCP_PORT

while true; do
    cmd=(dialog --keep-tite --menu "Your bidding?" 22 76 16)

    options=(1 "Error reports"
             2 "Job errors"
             3 "Psql"
             4 "Psql jobs")

    choices=$("${cmd[@]}" "${options[@]}"  2>&1 >/dev/tty)

    for choice in $choices
    do
        case $choice in
            1)
                echo '\x on \\ SELECT message, backtrace FROM error_reports ORDER BY id DESC limit 20' | psql canvas_production
                read
                ;;
            2)
                echo '\x on \\ SELECT last_error FROM delayed_jobs ORDER BY updated_at DESC' | psql canvas_queue_production
                read
                ;;
            3)
                psql canvas_production
                ;;
            4)
                psql canvas_queue_production
                ;;
        esac
    done
done
     
