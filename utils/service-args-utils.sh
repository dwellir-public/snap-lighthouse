#!/bin/sh

. "$SNAP/utils/utils.sh"

SERVICE_ARGS_FILE="$SNAP_COMMON/service-arguments"
DATADIR_PATH="$SNAP_COMMON/datadir"

write_service_args_file()
{
    service_args="--datadir=$DATADIR_PATH $(get_service_args)"
    log "Writing \"$service_args\" to $SERVICE_ARGS_FILE"
    echo "$service_args" > "$SERVICE_ARGS_FILE"
}

set_service_args()
{
    snapctl set service-args="$1"
    set_previous_service_args "$1"
}

# Set defaults if no service-args are found
# beacon_node 
# --network mainnet 
# --execution-endpoint http://localhost:8551 
# --execution-jwt /var/snap/lighthouse/common/jwt.hex
# --checkpoint-sync-url https://mainnet.checkpoint.sigp.io 
# --disable-deposit-contract-sync
get_service_args()
{
    DEFAULT_ARGS="beacon_node --network mainnet --execution-endpoint http://localhost:8551 --execution-jwt /var/snap/lighthouse/common/jwt.hex --checkpoint-sync-url https://mainnet.checkpoint.sigp.io --disable-deposit-contract-sync"

    service_args="$(snapctl get service-args)"
    if [ -z "$service_args" ]; then
        log "Setting default service args to service-args file"
        service_args="$DEFAULT_ARGS"
        snapctl set service-args="$service_args"
    fi
    echo "$service_args"
}

set_previous_service_args()
{
    snapctl set private.service-args="$1"
}

get_previous_service_args()
{
    snapctl get private.service-args
}

service_args_has_changed()
{
	[ "$(get_service_args)" != "$(get_previous_service_args)" ]
}

# Some arguments are forbidden to prevent failure:
# base-path
#
validate_service_args()
{
    case "$1" in 
        *datadir*)
            log_message="datadir is not allowed to pass as a service argument restoring to last used service-args. This path is alywas used instead ${DATADIR_PATH}."
            log "$log_message"
            # Echo will be visible for a user if the configure hook fails when calling e.g. snap set SNAP_NAME service-args
            echo "$log_message"
            set_service_args "$(get_previous_service_args)"
            exit 1
            ;;
        esac
}
