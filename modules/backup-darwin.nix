{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    restic
    bash
    coreutils
  ];

  launchd.user.agents.restic-backup = {
    script = ''
      #!${pkgs.bash}/bin/bash

      # --- Restic Credential Management Best Practice ---
      # This setup uses an external password file to keep your sensitive password
      # out of your Nix store and system logs. The password file itself needs
      # to be created and secured manually on your system (see steps below).

      # 1. Define the restic repository URL without embedded credentials.
      #    Restic will look for RESTIC_REST_USERNAME and RESTIC_REST_PASSWORD
      #    environment variables for HTTP authentication.
      export RESTIC_REPOSITORY="rest:https://restic.schnau.dev/"

      # 2. Define the REST backend username explicitly.
      export RESTIC_REST_USERNAME="schnau"

      # 3. Path to the secure file containing your single repository password.
      #    This file's content will be used for:
      #    - RESTIC_PASSWORD (for repository encryption/decryption)
      #    - RESTIC_REST_PASSWORD (for HTTP authentication to the REST backend)
      export RESTIC_PASSWORD_FILE="${config.system.primaryUserHome}/.config/restic/restic-repo-password"
      RESTIC_REST_PASSWORD_FILE="${config.system.primaryUserHome}/.config/restic/restic-rest-password"

      # 4. Read the password from the secure file.
      if [ ! -f "$RESTIC_REST_PASSWORD_FILE" ]; then
        echo "Error: Restic password file not found at $RESTIC_REST_PASSWORD_FILE" >&2
        exit 1
      fi
      # Using 'tr -d "\n"' to remove any trailing newline from the file content.
      # This is crucial for correctly reading single-line secrets.
      REPOSITORY_SECRET="$(cat "$RESTIC_REST_PASSWORD_FILE" | tr -d '\n')"

      if [ -z "$REPOSITORY_SECRET" ]; then
        echo "Error: Restic password file at $RESTIC_REST_PASSWORD_FILE is empty." >&2
        exit 1
      fi

      # 5. Export the password for both uses:
      export RESTIC_REST_PASSWORD="$REPOSITORY_SECRET"  # For REST backend HTTP auth

      # --- End Credential Management ---

      # Create the log directory if it doesn't exist.
      mkdir -p "''${HOME}/Library/Logs/restic"

      echo "Backing up at $(date)"

      ${pkgs.restic}/bin/restic \
        --skip-if-unchanged \
        --exclude-caches \
        --iexclude="caches" \
        --iexclude="cache" \
        --exclude-if-present=".git/" \
        --verbose \
        backup \
        ./Buildlinx \
        ./Code \
        ./Desktop \
        ./Documents \
        ./Downloads \
        ./Freelancing \
        ./Music \
        ./Obsidian \
        ./Pictures \
        ./Private \
        ./Reading \
        ./Studium \
        ./urbs
    '';

    path = with pkgs; [
      restic
      bash
      coreutils
    ];

    serviceConfig = {
      StartCalendarInterval = {
        Minute = 0; # Every hour on the hour
      };
      RunAtLoad = true;
      WorkingDirectory = config.system.primaryUserHome;
      StandardOutPath = "${config.system.primaryUserHome}/Library/Logs/restic/backup.log";
      StandardErrorPath = "${config.system.primaryUserHome}/Library/Logs/restic/error.log";
      ProcessType = "Background"; # Generally suitable for background tasks
    };
  };
}
