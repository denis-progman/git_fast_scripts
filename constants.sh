# font styles
bold=$(tput bold)
underline=$(tput sgr 0 1)
reset=$(tput sgr0)

# font colors
purple=$(tput setaf 171)
red=$(tput setaf 1)
green=$(tput setaf 76)
tan=$(tput setaf 3)
blue=$(tput setaf 38)

# output styles
p_header() { printf "\n${bold}${purple}==========  %s  ==========${reset}\n" "$@"
}
p_arrow() { printf "➜ $@\n"
}
p_success() { printf "${green}✔ %s${reset}\n" "$@"
}
p_error() { printf "${red}✖ %s${reset}\n" "$@"
}
p_warning() { printf "${tan}➜ %s${reset}\n" "$@"
}
p_underline() { printf "${underline}${bold}%s${reset}\n" "$@"
}
p_bold() { printf "${bold}%s${reset}\n" "$@"
}
p_notice() { printf "${underline}${bold}${blue}Note:${reset}  ${blue}%s${reset}\n" "$@"
}