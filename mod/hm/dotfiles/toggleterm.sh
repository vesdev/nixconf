#!/usr/bin/env bash

if ((KITTY_WINDOW_ID > 1))
then
  kitten @ first_window
else
  kitten @ second_window
fi

kitten @ toggle_layout stack

