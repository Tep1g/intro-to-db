### `ls`
lists all unhidden contents within the current directory.

### `ls -l`
lists all contents with the long listing format.
long list format includes file name, permissions, size, and date modified.

### `ls -a`
lists all unhidden and hidden contents within the current directory.

### `cd tests`
attempts to move to the "tests" directory.
fails if "tests" does not exist.

### `pwd`
prints the current directory.

### `mkdir example_dir`
Creates a directory with the name `example_dir` if it doesn't already exist.

### `ls -al > out`
Runs the `ls` command with the `-a` and `-l` flags, then copies the output of that command to a file called `out`.

### `more out`
Views the file `out` within the termal, press q to stop viewing.

### `chmod a+w out`
Changes the access writes of the file `out` to allow all users to write and delete it.

### `ls -al`
Runs the `ls` command with the `-a` and `-l` flags which lists all unhidden and hidden files with the long listing format.