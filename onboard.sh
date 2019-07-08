#!/bin/bash
# Jamf stores the current logged in user in $3
HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_201.jdk/Contents/Home

# General packages to install.
PACKAGES=(
        git
        maven
        nginx
        direnv
        ansible
        curl   
        tree
        vim
        openssl
        python3
        dockutil
)

# Installs linux versions of packages and ops cli tools.
OPSPACKAGES=(
    coreutils
    kubernetes-cli
    diffutils
    ed 
    findutils
    gawk
    gnu-indent
    gnu-sed
    gnu-tar
    grep
    gzip
    watch
    wget
)
# Updates outated osx version of packages
UPDATE=(
    bash
    make
)

function brew_install(){
  
   local arr="$1[@]"
   for i in "${!arr}";
      do
        brew install $i
          echo "$i"
      done

}

echo "export JAVA_HOME=$HOME" >> /Users/$3/.bash_profile
# Installing homebrew
osascript -e '

tell application "Terminal"
    activate
    do script ("/usr/bin/ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\"")
    repeat
        delay 0.5
        if not busy of window 1 then exit repeat
    end repeat
    close window 1
end tell
'
brew_install PACKAGES
brew tap homebrew/dupes
brew_install OPSPACKAGES
brew_install UPDATE

PATH="/usr/local/opt/make/libexec/gnubin:/usr/local/opt/grep/libexec/gnubin:/usr/local/opt/gnu-tar/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/gnu-indent/libexec/gnubin:/usr/local/opt/ed/libexec/gnubin:/usr/local/opt/ruby/bin:/usr/local/opt/coretils/libexec/gnubin:$PATH"
cp /jarConfig/files/*policy.jar  /jarConfig/files/java.security $HOME/jre/lib/security
cp /jarConfig/files/bcprov-jdk15on-160.jar $HOME/jre/lib/ext
echo "export PATH=$PATH" >> /Users/sean/.bash_profile
chown -R sean /Users/sean/.bash_profile

rm -rf jarConfig




exit 0
