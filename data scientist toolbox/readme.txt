Accessing the Help File in R:
___________________________________

?rnorm

help.search("rnorm")

Get Arguments:

args("rnorm")


General Stuff:
____________________________________

ls -a: displays hidden files and folders also

ls -al: displays hidden files and folders also + displays details

touch: creates an empty file

cp [file to copy] [path where to copy]: copy

cp -r Documents More_docs: copies contents of Documents into More_docs

rm: remove

rm -r More_docs: delete entire directory More_docs and its contents
This CANT be undone!

mv [file] [path]: moves files

mv can be used to rename files

mv new_file renamed_file: renames the file

Creating New Repo:

1. Create new repo in GitHub and select Create repo with Readme file option
2. mkdir [name of repo] and go to the repo's location
3. git init
4. Point the local repo to the remote Repo
    git remote add origin https://github.com/ShaunakSen/[repo name].git
5. Fork: create a copy of a repo in ur github profile, from which u can create a local copy by cloning

Add: Git monitors the file and keeps up with the changes
Commit: commit the changes
Push: Update remote repo

git add . : adds all new files in the current working directory
git add -u : adds tracking for files that changed names or were deleted
git add - A: does both the previous

git commit -m "message goes here"

git push

We can create a Branch.Branch is another version of the same directory where we can make changes independently
(Default Branch is master Branch)

Creating a Branch:
git checkout -b branchname

To see what Branch u r on:
git branch

To switch back to master branch:
git checkout master

Basic Markdown:

extension: .md

## secondary heading
### tertiary heading

* first item in list
* second item in list
* third item in list


R Packages:

CRAN and Bioconductor: primary source

available.packages() function shows all the packages

For CRAN:

install.packages([package name]) : installs the package and its dependencies

install.packages(c("first", "second", "third")): install multiple packages

For Bioconductor:

source("http://bioconductor.org/biocLite.R")
biocLite()

biocLite(c("first", "second"))


Loading packages:

After installing packages we need to load them

library(): used to load packages

library(ggplot2)

Note: dependencies need to be loaded first

library(ggplot2)
search(): see all functions that are part of the ggplot2 package

Rtools: collection of packages necessary to build R packages on windows

install.packages("devtools")

> library(devtools)
> find_rtools()
[1] TRUE





















