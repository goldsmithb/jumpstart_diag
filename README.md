# jumpstart_diag Onboarding Scripts

## Installing
1. Clone the repository: `git clone git@github.com:goldsmithb/jumpstart_diag.git`
2. Make the scripts executable: `chmod u+x jumpstart_dev && chmod u+x jumpstart_ghc`

## Scripts
### 1. jumpstart_dev
**Usage:**
```
jumpstart_dev
```
**Description:** Installs software related to developing our Rails Apps.

**What it does:**
  1. Install xcode command line tools
  2. Install Homebrew
  3. Install rbenv
  4. Install Ruby 3.3.5 and set it as the global version, using rbenv
  5. Install Rails gem
  6. Install VSCode

### 2. ghc
**Description:** Installs Columbia University Library repositories for DIAG projects.

**Usage:**
```
ghc <"all" or a list of project(s) separated by space>
```
Examples:
```
  % ghc all
  => Clones all repositories to the current directory.

  % ghc sword triclops
  => Clones the sword and triclops repositories to the current directory.
```
**What it does:**
`ghc` (short for "github clone") is just a wrapper around calls to `git clone X`.

This script can be used to clone repositories to your local machine.
I find it useful because then I don't need to navigate to github.com in order to find the proper SSH URL for each project.
