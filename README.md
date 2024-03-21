# Audit SSHD

## Setup

1. Prepare a directory with public keys, one file per user and bind it into `/users`:

  - `user1.pub`
  - `user2.pub`
  - *etc*

2. Bind any other directories in **readonly** mode.

3. Expose port 22

## Known errors

- Server's SSH keys are regenerated at a boot time, so clients will get scary security warning.

