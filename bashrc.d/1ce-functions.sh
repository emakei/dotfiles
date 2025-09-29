
function start-srv1cv8-8.3.21.1895 {
	start-service srv1cv8-8.3.21.1895@default.service 1
	start-service ras-8.3.21.1895.service 1
}

function stop-srv1cv8-8.3.21.1895 {
    stop-service srv1cv8-8.3.21.1895@default.service 1
    stop-service ras-8.3.21.1895.service 1
}

function start-postgrespro-1c-16 {
	start-service postgrespro-1c-16.service 1
}

function stop-postgrespro-1c-16 {
	stop-service postgrespro-1c-16.service 1
}

function status-postgrespro-1c-16 {
	service-status postgrespro-1c-16.service
}

function service-status {

	if [ $# -lt 1 ]
	then
		retval=$?
		echo "use 'service-status service-name'"
		echo "    service-name - name of service to check status"
	else
		systemctl status $1
	fi
}

function start-service {

	if [ $# -lt 1 ]
	then
		retval=$?
		echo "use 'start-service service-name [verbose]'"
		echo "    service-name - name of service to [re]start"
		echo "    verbosity    - need verbose output (1) or no (0). Default: 0"
	else
		if systemctl show $1 | grep 'ActiveState=active' > /dev/null
		then
			if [ $# -gt 1 ] && [ $2 -eq 1 ]
			then
				echo "Restarting '$1'..."
			fi
			systemctl restart $1
			retval=$?
		else
			if [ $# -gt 1 ] && [ $2 -eq 1 ]
			then
				echo "Starting '$1'..."
			fi
			systemctl start $1
			retval=$?
		fi
	fi

	if [ $# -gt 1 ] && [ $2 -eq 1 ]
	then
        	if [ $[retval] -eq 0 ]
        	then
                	echo "Ok"
        	else
                	echo "Error code: $?"
        	fi
	fi

	return $[retval]
}

function stop-service {

        if [ $# -lt 1 ]
        then
            	retval=$?
                echo "use 'stop-service service-name [verbose]"
                echo "    service-name - name of service to stop"
                echo "    verbosity    - need verbose output (1) or no (0). Default: 0"
        else
            	if systemctl show $1 | grep 'ActiveState=active' > /dev/null
                then
                    	if [ $# -gt 1 ] && [ $2 -eq 1 ]
                        then
                            	echo "Stopping '$1'..."
                        fi
                        systemctl stop $1
                        retval=$?
		else
			if [ $# -gt 1 ] && [ $2 -eq 1 ]
                        then
                                echo "Service '$1' is inactive..."
                        fi
			retval=$?
                fi
        fi

	if [ $# -gt 1 ] && [ $2 -eq 1 ]
        then
            	if [ $[retval] -eq 0 ]
                then
                    	echo "Ok"
                else
                        echo "Error code: $?"
                fi
        fi

        return $[retval]
}

function check-sonarqube-status {
	sh /opt/sonarqube/bin/linux-x86-64/sonar.sh status
}

function start-sonarqube-console {
	sh /opt/sonarqube/bin/linux-x86-64/sonar.sh console
}

