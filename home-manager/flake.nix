{
  description = "Z6's reproducible environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: 
    let
      system = "x86_64-linux";
      # FIXED: Proper allowUnfree configuration
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      
      # FIXED: Removed conflicting packages (gcc, clang, cargo, rustc)
      allPackages = with pkgs; [
        aircrack-ng     airgeddon       arping          bully
        cowpatty        amass           burpsuite       cadaver
        cewl            commix          dirb            dirbuster
        ffuf            gobuster        nikto           nuclei
        sqlmap          subfinder       theharvester    wpscan
        whatweb         enum4linux      eyewitness      lbd
        masscan         netdiscover     netexec         nmap
        crunch          hashcat         hash-identifier john
        autopsy         capstone        foremost        ghidra
        maltego         openssl         sherlock        steghide
        testdisk        yara            bettercap       ettercap
        mitmproxy       netcat          responder       socat
        tcpdump         wireshark       tshark          yersinia
        armitage        bloodhound      evil-winrm      mimikatz
        powershell      chkrootkit      crowbar         dmitry
        dnsenum         dnstracer       medusa          snort
        zenmap          git-lfs
       nixpkgs-fmt nix-diff nix-tree
      ];

      # Safe file copying function
      safeCopy = ''
        echo "📁 Copying config files..."
        
        # Copy config directories if they exist
        if [ -d "${self}/dotfiles/config" ]; then
          mkdir -p ~/.config
          for dir in "${self}"/dotfiles/config/*; do
            if [ -d "$dir" ]; then
              dir_name=$(basename "$dir")
              echo "  Copying ~/.config/$dir_name/"
              cp -r "$dir" ~/.config/ 2>/dev/null || true
            fi
          done
        fi
        
        # Copy home dotfiles if they exist
        if [ -d "${self}/dotfiles/home" ]; then
          for file in "${self}"/dotfiles/home/.*; do
            if [ -f "$file" ] && [ "$file" != "${self}/dotfiles/home/." ] && [ "$file" != "${self}/dotfiles/home/.." ]; then
              file_name=$(basename "$file")
              echo "  Copying ~/$file_name"
              cp "$file" ~/ 2>/dev/null || true
            fi
          done
        fi
        
        # Copy themes if they exist
        if [ -d "${self}/themes" ]; then
          mkdir -p ~/.themes
          echo "  Copying ~/.themes/"
          cp -r "${self}"/themes/* ~/.themes/ 2>/dev/null || true
        fi
        
        echo "✅ Config files copied!"
      '';

    in {
      # Development shell with ALL packages
      devShells.${system}.default = pkgs.mkShell {
        name = "z6-environment";
        
        packages = allPackages;

        shellHook = ''
          echo "🚀 Z6's complete environment activated!"
          echo "All ${toString (builtins.length allPackages)} packages available"
          echo ""
          echo "Your config files are available at:"
          echo "  Configs: ${self}/dotfiles/config/"
          echo "  Dotfiles: ${self}/dotfiles/home/"
          echo "  Themes: ${self}/themes/"
          echo ""
          echo "To copy configs to your home directory, run:"
          echo "  copy-configs"
          echo ""
          cowsay "Ready to hack!"
          
          # Add helper command
          copy-configs() {
            ${safeCopy}
          }
        '';
      };

      # App to install packages and configs (FIXED: removed package conflict)
      apps.${system}.default = {
        type = "app";
        program = toString (pkgs.writeShellScript "z6-install" ''
          # Copy config files first (this always works)
          ${safeCopy}
          
          echo "📦 Setting up development environment..."
          echo "Run 'nix develop' to enter environment with all packages"
          echo "Or install specific packages with: nix profile install nixpkgs#package-name"
          echo ""
          echo "✅ Config files installed! Use 'nix develop' for packages."
        '');
      };

      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}
