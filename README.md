# README

What are the issues with the controller code below?
How would you fix it? Assume ~500k posts

## Issue
The controller has an inefficient process of loading entire tables and iterating over records on the server side.

## Improvement
1. Add request test to protect endpoint behaviour.
2. Shift process to database.
3. Adding pagination.