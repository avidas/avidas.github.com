---
layout: post
title: "Bug hunting with git bisect"
date: 2014-08-30 12:55
comments: true
categories: Git, Bash, Debugging, Shell
---

With large projects with Git, feature development tends to happen often in separate branches before they are ready for merge. However, once the merge happens and tests break, it's often challenging to figure out at which point the bug got introduced. Git bisect is an excellent tool to triage at which commit the bug got introduced. It does so in a binary search like fashion, marking good and bad commits and reducing problem space of commits by half every time.

However, this process can be quite manual so git bisect has a run command. This allows you to set a testing scipt and based on the output of the testing script, it automatically finds the middle commits and continues searching till it finds the breaking commit.

Another neat feature is its ability to log out the output, record and rerun the bisect for further debugging. The git-scm book has some excellent documentation about the [complete api](http://git-scm.com/docs/git-bisect) and [technical details](http://git-scm.com/docs/git-bisect-lk2009.html).

There are still a few manual steps, as you would want to stash for saving and recovering state to keep uncommitted work, get to HEAD and view the log available for record and replay.

For reusability, I wrote the following script to make git bisecting and setup into a handy bash function.

```bash
# Stash current work and and git bisect with given good and 
# bad commit ids, running given script that exits with 0 on failure
# and positive number on success
gbisect() {
    if [ "$#" -ne 1 ]; then
        echo "gbisect good-commit-id bad-commit-id script <arguments>"
    else
        git stash # stash current state
        git checkout HEAD
        git bisect start # initialize git bisect
        git bisect good $1
        shift
        git bisect bad $1
        shift
        git bisect run "$@" # # git bisect 

        git bisect log
        git bisect reset

        git stash list
        git stash apply
    fi
}
```

If you are using mocha as a test runner, you could use the script as following

```bash
gbisect 23df33 56dg23 mocha -t 15000
```

Git is like an iceberg, in a good way. Generally instead of perusing heavy books on something, I like learning it as I run into challenges. Once something clicks though, it is great as it has a N times effect into your workflow if you are using git for work and personal projects.