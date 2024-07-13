# Ensure commands in interactive sessions
if status is-interactive
    # Define the postexec function. This adds a newline after each command.
    function postexec
        echo ""
    end

    # Add an event handler for the fish_postexec event
    function __postexec_handler --on-event fish_postexec
        postexec
    end
end
