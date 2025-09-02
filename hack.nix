{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Network & Wireless tools
    aircrack-ng airgeddon arping bully cowpatty 
    
    # Web application testing
    amass burpsuite cadaver cewl commix dirb dirbuster ffuf gobuster
    nikto nuclei sqlmap subfinder theharvester wpscan whatweb
    
    # Vulnerability scanning & enumeration
    enum4linux eyewitness lbd masscan netdiscover netexec nmap
    
    # Password cracking
    crunch hashcat hash-identifier john
    
    # Forensic & analysis tools
    autopsy capstone foremost ghidra maltego openssl 
    sherlock steghide testdisk yara
    
    # Network tools & MITM
    bettercap ettercap mitmproxy netcat responder socat tcpdump
    wireshark tshark yersinia
    
    # Windows tools
    armitage bloodhound evil-winrm mimikatz powershell
    
    # Other security tools
    chkrootkit crowbar dmitry dnsenum dnstracer medusa snort zenmap
    
    # Git LFS for your MP3 files
    git-lfs
  ];

  shellHook = ''
    echo "Penetration Testing Environment Loaded!"
    echo "Available tools loaded successfully"
    
  '';
}
