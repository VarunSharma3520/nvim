#!/bin/bash


# Define an array of options
options=(
  "google"
  "youtube"
  "duckduckgo"
  "w3schools"
  "express docs"
  "bash devhint"
  "mongoose docs"
  "tailwindcss docs"
  "react docs"
  "nextjs"
  "rust-lang book"
  "go docs"
  "rustc book"
  "rustdoc"
  "rust-clippy book"
  "cargo book"
  "pypi"
  "npm registry"
  "github/code"
  "github"
  "chatGPT"
  "phind"
  "gemini"
  "exit"
)

# Function to URL-encode a string using Python
url_encode() {
  python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$1"
}

# Display a list of options using fzf
selected_option=$(printf "%s\n" "${options[@]}" | fzf --prompt="Choose an option: ")

# Check the selected option and perform an action
case $selected_option in
    "express docs")
        # Open the URL in Brave browser
        brave-browser "https://expressjs.com/en/4x/api.html"
        ;;

    "bash devhint")
        # Open the URL in Brave browser
        brave-browser "https://devhints.io/bash"
        ;;

   "mongoose docs")
        # Open the URL in Brave browser
        brave-browser "https://mongoosejs.com/docs/"
        ;;

    "w3schools")
        # Open the URL in Brave browser
        brave-browser "https://www.w3schools.com/"
        ;;

    "pypi")
        # Open the URL in Brave browser
        brave-browser "https://pypi.org/"
        ;;

    "npm")
        # Open the URL in Brave browser
        brave-browser "https://www.npmjs.com/"
        ;;

    "npm registry")
        # Open the URL in Brave browser
        brave-browser "https://www.npmjs.com/"
        ;;

    "go docs")
        # Open the URL in Brave browser
        brave-browser "https://go.dev/doc/"
        ;;

    "cargo book")
        # Open the URL in Brave browser
        brave-browser "https://doc.rust-lang.org/beta/cargo/index.html"
        ;;

    "rustc book")
        # Open the URL in Brave browser
        brave-browser "https://doc.rust-lang.org/beta/rustc/index.html"
        ;;

    "rustdoc")
        # Open the URL in Brave browser
        brave-browser "https://doc.rust-lang.org/beta/rustdoc/index.html"
        ;;

    "rust-clippy book")
        # Open the URL in Brave browser
        brave-browser "https://doc.rust-lang.org/beta/clippy/index.html"
        ;;


    "rust-lang book")
        # Open the URL in Brave browser
        brave-browser "https://doc.rust-lang.org/book/index.html"
        ;;

    "react docs")
        # Open the URL in Brave browser
        brave-browser "https://react.dev/"
        ;;
    
    "nextjs")
        # Open the URL in Brave browser
        brave-browser "https://nextjs.org/"
        ;;

    "github/code")
        # Open the URL in Brave browser
        brave-browser "https://github.com/VarunSharma3520/code"
        ;;

    "github")
        # Open the URL in Brave browser
        brave-browser "https://github.com/VarunSharma3520/"
        ;;

    "tailwindcss docs")
        # Open the URL in Brave browser
        brave-browser "https://tailwindcss.com/docs/installation"
        ;;

    "chatGPT")
        # Open the URL in Brave browser
        brave-browser "https://chat.openai.com/"
        ;;

    "phind")
        # Open the URL in Brave browser
        brave-browser "https://www.phind.com/search?home=true"
        ;;

    "gemini")
        # Open the URL in Brave browser
        brave-browser "https://gemini.google.com/"
        ;;

    "duckduckgo")
        # Prompt the user to enter a search query
        read -p "Enter search query: " query
        # URL-encode the query
        encoded_query=$(url_encode "$query")
        echo "Searching DuckDuckGo for: $query"
        # Open the DuckDuckGo search results in Brave browser
        brave-browser "https://duckduckgo.com/?q=$encoded_query"
        ;;

    "youtube")
        # Prompt the user to enter a search query
        read -p "Search: " query
        # URL-encode the query
        encoded_query=$(url_encode "$query")
        echo "Searching YouTube for: $query"
        # Open the YouTube search results in Brave browser
        brave-browser "https://www.youtube.com/search?q=$encoded_query"
        ;;

    "google")
        # Prompt the user to enter a search query
        read -p "Search: " query
        # URL-encode the query
        encoded_query=$(url_encode "$query")
        echo "Searching Google for: $query"
        # Open the Google search results in Brave browser
        brave-browser "https://www.google.com/search?q=$encoded_query"
        ;;

    "exit")
        exit 0
        ;;

    *)
        echo "No valid selection made."
        ;;
esac
