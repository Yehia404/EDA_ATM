#!/bin/bash

file1="E:\ASU\Semester 5\EDA\EDA_ATM\output_design.txt"
file2="E:\ASU\Semester 5\EDA\EDA_ATM\output_ref.txt"

if cmp -s "$file1" "$file2"; then
    printf 'The file "%s" is the same as "%s"\n' "$file1" "$file2"
else
    printf 'The file "%s" is different from "%s"\n' "$file1" "$file2"
fi