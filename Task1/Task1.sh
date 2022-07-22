#!/bin/bash
awk '/-|--/{print $0}' filename >> newfile