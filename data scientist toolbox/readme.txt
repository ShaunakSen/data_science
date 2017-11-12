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


Data Analysis: Introduction
___________________________________


Data : Data are the values of qualitative and quantitative variables, belonging to a set of items

Set of items: population

Variables: measurement or characteristic of an item

Data is often available in raw format, so we need to parse it properly

Data may be a video or audio also!

https://www.data.gov/: has a lot of data sets

The most important thing in Data Science is the Question
Data is the second most important thing
often Data will limit or enable the Question

Hadoopis an incredibly useful and powerful technique iff ur data is v v large
But if we have a powerful computer we can analyze data locally

figshare: share data here

Alternative: https://github.com/jtleek/datasharing

Study by Barack Obama:

Question: Which text in a website invites donations more?

Experiment:
1. Randomly show visitors one version or the other
2. Measure how much they donate
3. Determine which is better

Statistical Inference:

population is all the people in US who might visit the website

A small subset is selected based on some probability

This results in a small sample
Then we get Descriptive Statsistics (ave number of donations) on this sample

Then we use Inferential Statsistics to decide whether the result will be same for entire population


Correlation is not Causation:

S and L may be directly correlated. But that does not mean that S causes L because an unknown factor A might be causing Loading

So how to fix this?

Randomization and Blocking:

- we can fix a variable so that it does not interfere
- stratify the var i.e use each one of them equally
- randomize the var

Prediction Key Quantities:

Suppose there are 2 vars: Disease and Test

for eg Disease=True and Test=True implies true positive

Sensitivity: P(positive test | Disease)
Specificity: P(negative test | no Disease)
Positive Predictive Value: P(Disease | positive test) --- most important
Negative Predictive Value: P(no Disease | negative test)
Accuracy: P(correct outcome)


R Programming:
___________________________________

getwd(): get current working directory

> getwd()
[1] "C:/Users/Shaunak/Documents"

In R console:
File -> change dir -> Dekstop

> getwd()
[1] "C:/Users/Shaunak/Desktop"

> dir()
[1] "desktop.ini"            "HOUSE RENT ADVANCE.pdf"

read.csv("myData.csv"): Reads a CSV file



















