import yaml

with (config.configdir / 'colors.yml').open() as f:
    yaml_data = yaml.load(f)

def dict_attrs(obj, path=''):
    if isinstance(obj, dict):
        for k, v in obj.items():
            yield from dict_attrs(v, '{}.{}'.format(path, k) if path else k)
    else:
        yield path, obj

for k, v in dict_attrs(yaml_data):
    config.set(k, v)

c.url.searchengines = {
        'DEFAULT': 'https://www.google.com/search?hl=en&q={}',
        'i': 'https://duckduckgo.com/?q={}&iar=images&iax=images&ia=images',
        'r': 'https://reddit.com/r/{}',
        'wt': 'http://en.wiktionary.org/?search={}',
        'jp': 'http://buyee.jp/item/search/query/{}',
        'tw': 'https://twitter.com/{}',
        'am': 'https://www.amazon.co.uk/s/ref=nb_sb_noss_2?url=search-alias%3Daps&field-keywords={}',
        'ali': "https://www.aliexpress.com/wholesale?catId=0&initiative_id=SB_20180518083944&SearchText={}",
        '8': 'https://8ch.net/{}',
        'eb': 'https://ebay.co.uk/sch/{}',
        'aw': 'https://wiki.archlinux.org/index.php?title=Special%3ASearch&search={}',
        '4cat': 'https://boards.4chan.org/{}/catalog',
        'lain': 'http://lainchan.org/{}',
        'gw': 'https://wiki.gentoo.org/index.php?title=Special%3ASearch&search={}',
        '8cat': 'https://8ch.net/{}/catalog.html',
        'yt': 'https://www.youtube.com/results?search_query={}',
        'ig': 'https://wiki.installgentoo.com/index.php?search={}&title=Special%3ASearch',
        'w': 'https://www.wikipedia.org/search-redirect.php?family=wikipedia&language=en&search={}&language=en&go=Go',
        '4': 'https://boards.4chan.org/{}',
        'vw': 'https://wiki.voidlinux.eu/index.php?search={}&title=Special%3ASearch',
        'thw': 'http://www.thinkwiki.org/w/index.php?search={}&title=Special%3ASearch',
        'vw': 'http://vim.wikia.com/wiki/Special:Search?fulltext=Search&query={}',
        'intel': 'https://ark.intel.com/search?q={}',
        'gum': 'https://www.gumtree.com/search?search_category=all&q={}',
        'ow': 'https://www.overbuff.com/search?q={}',
        'gh': 'https://github.com/search?utf8=%E2%9C%93&q={}&type=',
        'phone': 'https://www.gsmarena.com/res.php3?sSearch={}',
        'wiki': 'https://en.wikipedia.org/w/index.php?search={}',
        }
# Tab Customisation

# Sest the tabs to only show while switching tabs, rather than all the time
c.tabs.show = 'switching'

# Disables the favicons ( icons ) in the tab bar

# Statusbar customisation

c.statusbar.hide = True

# Home screen

# Sets the page when using :open with no argument to my startup-page
c.url.default_page = '~/startup-page/index.html'

# Sets the startup page to my startup-page
c.url.start_pages = '~/startup-page/index.html'

# Hints Customisation

#Sets the hints to uppercase characters
c.hints.uppercase = True

# Custom Bindings

# Open the hint url in it's suitable application, use M if you want youtube to open in mpv.
config.bind('M', 'hint links spawn mpv --loop {hint-url}')
# config.bind('\M', 'hint links spawn xdg-open {hint-url}')
config.bind('Y', 'hint links yank {hint-url}') 

# Open the URL in a new tab
config.bind('t', 'set-cmd-text :open -t ')

# Use vim as an editor
