#!/bin/bash

set -e

git init
exec pod install
exec xcodegen
