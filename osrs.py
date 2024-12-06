#!/usr/bin/env python3

import requests
import sys
import webbrowser

def search_osrs_wiki(query):
    # URL for OSRS Wiki search
    search_url = "https://oldschool.runescape.wiki/api.php"
    
    # Parameters for the API search query
    params = {
        "action": "query",
        "list": "search",
        "srsearch": query,
        "format": "json"
    }

    # Custom headers with User-Agent
    headers = {
        "User-Agent": "OSRS-Wiki-Search-Terminal/1.0 (+https://github.com/yourusername/osrs-wiki-search)"
    }

    try:
        response = requests.get(search_url, params=params, headers=headers)
        response.raise_for_status()
        results = response.json().get("query", {}).get("search", [])
        
        if not results:
            print(f"No results found for '{query}'.")
            return
        
        print(f"Search results for '{query}':\n")
        for i, result in enumerate(results[:5], 1):  # Display top 5 results
            print(f"{i}. {result['title']}")
        
        # Open the first result in the browser
        choice = input("\nEnter the number of the result to open it in your browser (or press Enter to quit): ")
        if choice.isdigit() and 1 <= int(choice) <= len(results):
            selected = results[int(choice) - 1]
            page_title = selected['title'].replace(" ", "_")
            webbrowser.open(f"https://oldschool.runescape.wiki/w/{page_title}")
        else:
            print("Exiting without opening a page.")
    
    except requests.exceptions.RequestException as e:
        print(f"Error while connecting to OSRS Wiki: {e}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: osrs_wiki_search.py <search query>")
    else:
        search_query = " ".join(sys.argv[1:])
        search_osrs_wiki(search_query)

