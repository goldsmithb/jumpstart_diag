#!/usr/bin/env ruby

# frozen_string_literal: true

# ghc is a ruby script meant to help automate the cloning of public Github 
# repositories owned by Columbia University Libraries that are managed by DIAG.

USAGE = "Usage: ghc [options] (all | <project name>...)
When given 'all' in place of a list of project names, ghc will clone all of the repositories listed by `ghc --list` to your current directory.
  options:
    -h, --help\tdisplay this message
    -l, --list\tlist all the repos available for cloning

Nota Bene : this script assumes you are a member of the CUL organization on Github and can therefore clone public repositories.
"

REPO_TO_URL = {
  "triclops" => "git@github.com:cul/triclops.git",
  "folio_sync" => "git@github.com:cul/folio_sync.git",
  "folio_api_client" => "git@github.com:cul/folio_api_client.git",
  "derivativo" => "git@github.com:cul/ren-derivativo.git",
  "sword" => "git@github.com:cul/ldpd-sword.git",
  "hyacinth" => "git@github.com:cul/ldpd-hyacinth.git",
  "academic_commons" => "git@github.com:cul/ac-academiccommons.git",
  "hours_manager" => "git@github.com:cul/ldpd-hours.git",
  "omeka" => "git@github.com:cul/Omeka.git",
}

def print_repo_list
  puts "The following projects are available for cloning:"
  REPO_TO_URL.keys.each do |name|
    puts "\t#{name}"
  end
  puts "Pass one or more names to the `ghc` command to clone a repo."
end

def handle_bad_arg *args
  puts "[ghc] Could not match argument with a known github repository name: "
  args.each { |arg| puts "[ghc]\t#{arg}"}
  exit! false
end

################################################################################
#############################  SCRIPT  #########################################
################################################################################
dl_list = []

if (ARGV.length == 0)
  puts USAGE
  return
end

if ARGV.length == 1 
  # todo here cases: -h, -l, all, just one repo
  case arg = ARGV[0]
  when "-h", "--help"
    puts USAGE
    exit! false 
  when "-l", "--list"
    print_repo_list
    exit! false 
  when "all"
    dl_list = REPO_TO_URL.keys
  else # A single repository was specified for download
    handle_bad_arg unless REPO_TO_URL.key? arg
    dl_list.push(arg)
  end
else # ARGV.length > 1
  # add each to dl list
  ARGV.each do |project_name|
    handle_bad_arg unless REPO_TO_URL.key? project_name 
    dl_list.push(project_name)
  end
end

# Spawn a thread to clone each repository concurrently
tids = []
dl_list.map do |repo|
  tids << Thread.new { `git clone #{REPO_TO_URL[repo]}` }
end

tids.each { |thr| thr.join }

puts "[ghc] Finished cloning repo(s)!"