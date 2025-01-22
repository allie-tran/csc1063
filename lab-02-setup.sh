#!/bin/bash

# Create the base directory structure.
mkdir -p ~/demo/{csc1063,docs,projects}

# Create sample files in csc1063.
cd ~/demo/csc1063
for i in {1..5}; do
  echo "This is file $i in csc1063." > file$i.txt
  touch file$i.pdf
  echo "function exampleFunction$i() { return $i; }" > script$i.js
done

# Create subdirectories and files in docs.
cd ~/demo/docs
mkdir -p reports drafts
for i in {1..3}; do
  echo "Report $i contents." > reports/report$i.txt
  echo "Draft $i contents." > drafts/draft$i.md
done

# Create sample files in projects.
cd ~/demo/projects
mkdir -p projectA projectB
for i in {1..2}; do
  echo "This is projectA file $i." > projectA/fileA$i.txt
  echo "This is projectB file $i." > projectB/fileB$i.log
  echo "function projectFunction$i() { return $i; }" > projectB/scriptB$i.js
done

# Create large files for demonstration.
cd ~/demo
mkdir large_files
head -c 2M </dev/urandom > large_files/large1.txt
head -c 1M </dev/urandom > large_files/large2.txt

# Create a readme file in the demo folder.
echo "This is a README file for the demo folder." > ~/demo/README.md

# Output the directory structure and created files.
echo "Directory structure created under ~/demo with the following contents:"
find ~/demo
