#!/bin/bash

# Delete lontara build first
rm lontara.gem

# Then build gem from gemspec
gem build lontara-utilities.gemspec -o lontara.gem
