## Tmux
*  Prefix (`PRE`) is binded to `C-q`.
*  Split pane:
   -  Horizontally: `PRE |`.
   -  Vertically: `PRE -`.
   -  `PRE PRE` cycles to next pane.
*  List all available colours:

    ```sh
    for i in {0..255} ; do
      printf "\x1b[38;5;${i}mcolour${i}\n"
    done
    ```
