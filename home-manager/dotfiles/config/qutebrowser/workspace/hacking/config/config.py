# ===== BASIC CONFIGURATION =====
config.load_autoconfig(False)

# ===== CORE COLOR SETTINGS =====

# Initialize with stylesheet disabled
config.load_autoconfig()
config.set('content.user_stylesheets', ['~/.config/qutebrowser/green-black.css'])
# Corrected single toggle key
config.bind(',st', 
    'config-cycle content.user_stylesheets [] ["~/.config/qutebrowser/green-black.css"] ;; ' +
    'jseval -q py:message.info("Green/Black theme " + ' +
    '("ENABLED" if config.val.content.user_stylesheets else "DISABLED"))',
    mode='normal')

# Text colors (All green #00FF4C)
c.colors.completion.fg = '#00FF4C'
c.colors.completion.category.fg = '#00FF4C'
c.colors.statusbar.normal.fg = '#00FF4C'
c.colors.statusbar.insert.fg = '#00FF4C'
c.colors.statusbar.command.fg = '#00FF4C'
c.colors.statusbar.url.fg = '#00FF4C'
c.colors.hints.fg = '#00FF4C'
c.colors.contextmenu.menu.fg = '#00FF4C'

# Background colors (All black #000000)
c.colors.completion.category.bg = '#000000'
c.colors.completion.odd.bg = '#000000'
c.colors.completion.even.bg = '#000000'
c.colors.statusbar.normal.bg = '#000000'
c.colors.statusbar.insert.bg = '#000000'
c.colors.statusbar.command.bg = '#000000'
c.colors.tabs.bar.bg = '#000000'
c.colors.hints.bg = '#000000'
c.colors.contextmenu.menu.bg = '#000000'

# ===== TAB COLORS =====
# Selected tab (green background, black text)
c.colors.tabs.selected.odd.fg = '#000000'
c.colors.tabs.selected.odd.bg = '#00FF4C'
c.colors.tabs.selected.even.fg = '#000000'
c.colors.tabs.selected.even.bg = '#00FF4C'

# Other tabs (black background, green text)
c.colors.tabs.odd.fg = '#00FF4C'
c.colors.tabs.odd.bg = '#000000'
c.colors.tabs.even.fg = '#00FF4C'
c.colors.tabs.even.bg = '#000000'

# Context menu selection
c.colors.contextmenu.selected.fg = '#000000'
c.colors.contextmenu.selected.bg = '#00FF4C'

# ===== SIDEBAR CONFIGURATION =====
c.tabs.position = 'left'
c.tabs.show = 'always'
c.tabs.width = '12%'
c.tabs.indicator.width = 0  # No tab underline
c.tabs.padding = {'bottom': 2, 'left': 2, 'right': 2, 'top': 2}
c.tabs.title.alignment = 'left'
c.tabs.favicons.show = 'always'
c.tabs.min_width = 80
c.tabs.max_width = 150

# ===== FONT SETTINGS =====
c.fonts.default_family = 'monospace'
c.fonts.default_size = '11pt'
c.fonts.tabs.selected = '11pt monospace'
c.fonts.tabs.unselected = '11pt monospace'
c.fonts.statusbar = '11pt monospace'
c.fonts.hints = 'bold 11pt monospace'

# ===== WEB CONTENT SETTINGS =====
c.colors.webpage.preferred_color_scheme = 'dark'
c.colors.webpage.bg = 'black'

# ===== START PAGES =====
c.url.start_pages = ['~/.config/qutebrowser/home/index.html']
c.url.default_page = '~/.config/qutebrowser/home/index.html'

# ===== DARK MODE POLICY =====
# Disabled to prevent conflicts with our CSS
c.colors.webpage.darkmode.enabled = False
c.colors.webpage.darkmode.policy.images = 'never'
c.colors.webpage.darkmode.policy.page = 'always'

# In config.py
config.bind(',ws', 'session-save work')
config.bind(',wl', 'session-load work ;; close')
# Create a tab stack
config.bind(',tg', 'tab-give')

# Navigate stacks
config.bind(',tn', 'tab-focus next')
config.bind(',tp', 'tab-focus prev')

# Move tabs between stacks
config.bind(',tm', 'tab-move')

# In config.py
c.auto_save.session = True  # Auto-save session on exit
c.session.default_name = 'default'  # Default session name

config.bind(',wd1', 'spawn --userscript switch-workspace hacking')
config.bind(',wd2', 'spawn --userscript switch-workspace study')
config.bind(',wd3', 'spawn --userscript switch-workspace z6')

# Opens new workspace while keeping current window open (capital W)
config.bind(',W1', 'spawn --userscript open-workspace hacking')
config.bind(',W2', 'spawn --userscript open-workspace study')
config.bind(',W3', 'spawn --userscript open-workspace z6')

# ===== COMPLETE AD-BLOCKING CONFIGURATION =====
# Enable ad-blocking system
c.content.blocking.enabled = True

# Blocking method (options: 'auto', 'adblock', 'hosts', 'both')
c.content.blocking.method = 'both'  # 'auto' = smart combination of methods

# ===== ADBLOCK LISTS (EasyList format) =====
c.content.blocking.adblock.lists = [
    # Essential filters
    'https://easylist.to/easylist/easylist.txt',  # General advertisements
    'https://easylist.to/easylist/easyprivacy.txt',  # Tracking protection
    'https://easylist-downloads.adblockplus.org/easylist.txt',  # Mirror
    
    # Anti-annoyance
    'https://secure.fanboy.co.nz/fanboy-annoyance.txt',  # Cookie notices, popups
    'https://easylist.to/easylist/fanboy-social.txt',  # Social media widgets
    
    # Regional filters (uncomment if needed)
    # 'https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt',  # Anti-CoinHive
    # 'https://stanev.org/abp/adblock_bg.txt',  # Bulgarian ads
]

# ===== HOSTS-BASED BLOCKING =====
c.content.blocking.hosts.lists = [
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts',  # Standard
    'https://someonewhocares.org/hosts/zero/hosts',  # More aggressive
    # 'https://raw.githubusercontent.com/AdAway/adaway.github.io/master/hosts.txt',  # Mobile-focused
]

# ===== ADVANCED SETTINGS =====
# Whitelist certain sites (if needed)
c.content.blocking.whitelist = [
    # '*.example.com',  # Uncomment and add sites that break
]

# Block WebRTC IP leakage (privacy)
c.content.webrtc_ip_handling_policy = 'disable-non-proxied-udp'

# Block JavaScript popups
c.content.javascript.modal_dialog = False

# ===== KEYBINDS FOR ADBLOCK CONTROL =====
config.bind(',au', 'adblock-update', mode='normal')  # Update blocklists
config.bind(',at', 'adblock-toggle', mode='normal')  # Toggle ad-blocking
