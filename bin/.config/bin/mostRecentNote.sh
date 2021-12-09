#!/bin/sh

ls -r /Users/youngjaelim/Google\ Drive/My\ Drive/Notes/src/pdf/*.pdf | head -n1 | xargs -I {} zathura "{}"
