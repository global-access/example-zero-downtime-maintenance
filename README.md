## Example programs to show the zero downtime migration of a VM

These programs are created for an article about zero-downtime maintenance
https://www.global.de/en/blog/zero-downtime-maintenance/ It shows that when we
move VMs from one server to another, there is no percievable downtime to the
application.

### Prerequisites

To make the examples work, you'll need:

- access to a running PostgreSQL database. **WARNING: Do not use these examples
with your production database! The programs delete data and are only for
experiments.**
- haskell stack tool. You can get it from https://haskell-lang.org/get-started
- postgresql client development library: libpq
- and have a copy of SecretExample.hs put to Secret.hs, and enter correct
connection details

### Running the examples

1. Make sure to run `stack prepare.hs` first. It will make sure the database is
   set up correctly
2. Running `stack watch-writing.hs` will replace everything in the table with
   one entry - a number from an infinite growing sequence
3. Running `stack watch-reading.hs` parallel to the writing program one can see
   how the number is changing.

Both writing and reading programs print the duration of every operation they
make so one can see how responsive the database is.
