{
  config,
  pkgs,
  ...
}: {
  # Enable the Restic service in Home Manager
  services.restic.enable = true;

  services.restic.backups.myHomeBackup = {
    # The repository to back up to. For the `rest` backend,
    # the password can be included directly in the URL for HTTP Basic Auth.
    # For other backic backends, consider using `passwordFile` or `environmentFile`
    # for more secure credential handling.
    # repositoryFile = ./resty-backup;
    repository = "./restic-repo";
    passwordFile = "./resty-password";

    # Initialize the repository if it does not already exist.
    initialize = true;

    # Paths to back up. These paths are relative to your home directory
    # when the systemd service runs.
    paths = [
      "./Buildlinx"
      "./Code"
      "./Desktop"
      "./Documents"
      "./Downloads"
      "./Freelancing"
      "./Music"
      "./Obsidian"
      "./Pictures"
      "./Private"
      "./Reading"
      "./Studium"
      "./urbs"
    ];

    # Extra arguments passed directly to the 'restic backup' command.
    # This includes flags like --skip-if-unchanged, --verbose,
    # and various exclude options (--exclude-caches, --iexclude, --exclude-if-present)
    # which are treated as specific flags rather than generic patterns
    # by the `services.restic.backups.<name>.exclude` option.
    extraBackupArgs = [
      "--skip-if-unchanged"
      "--exclude-caches"
      "--iexclude=caches" # Case-insensitive exclude
      "--iexclude=cache" # Case-insensitive exclude
      "--exclude-if-present=.git/" # Exclude directories containing '.git/'
      "--verbose"
    ];

    # Prevents the system from sleeping while backing up.
    # If you encounter issues, you might need to enable Polkit:
    # `security.polkit.enable = true;` in your NixOS configuration (if applicable).
    inhibitsSleep = true;

    # Configure a systemd timer for periodic backups.
    # This example runs on boot and then every 24 hours after the last run.
    # You can customize `OnUnitActiveSec` or use `onCalendar` for specific schedules
    # (e.g., `onCalendar = "daily";` or `onCalendar = "weekly";`).
    timerConfig = {
      onBoot = true; # Run once when the system boots
      OnUnitActiveSec = "5m"; # Then run approximately every 24 hours
      persistent = true; # Ensures the timer keeps track of the last run across reboots
    };

    # It's highly recommended to periodically check the repository for consistency.
    # This will run `restic check` after the backup.
    runCheck = true;
    checkOpts = [
      "--check-data" # Check that the actual data can be read and decrypted
      "--check-struct" # Check the repository structure
    ];

    # Optionally, configure pruning to automatically remove old snapshots based on a policy.
    # Uncomment and adjust these options as needed for your retention policy.
    # pruneOpts = [
    #   "--keep-daily 7"    # Keep 7 daily snapshots
    #   "--keep-weekly 4"   # Keep 4 weekly snapshots
    #   "--keep-monthly 12" # Keep 12 monthly snapshots
    #   "--keep-yearly 1"   # Keep 1 yearly snapshot
    #   "--prune"           # Make sure to include --prune to actually delete data
    # ];
  };
}
