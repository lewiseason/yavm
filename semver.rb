#!/usr/bin/env ruby

version_files = [
  '.semver',
  'package.json',
  'bower.json'
]

def git_dir
  `git rev-parse --show-toplevel`
end
