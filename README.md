# Pingbypass Installer

## Free VPS List:

### Requires Credit Card

#### Amazon AWS Hosting (Free For 12 Months)
#### Google Cloud (Free For 3 Months)

### Does Not Require Credit Card

#### Google Cloud Shell
#### IBM Linux ONE



# Pingbypass Road Warrior Installer
A script to install and configure 3arthh4ck Pingbypass as quickly as possible on any Linux distro. This is largely a "[road warrior](https://www.merriam-webster.com/dictionary/road%20warrior)" style install, suitable for systems like NeverInstall or a loaned VPS as it does not need port forwarding, and makes use of large hacks unsuitable for a typical Pingbypass install.

The only dependency needed is wget, which should already be installed on most distros/VPS images. You will need to be able to communicate on all ports, and have an unfiltered internet connection.

Sandstar Pingbypass can be found at https://discord.gg/5HVsNJrVWM

## Usage
1. In terminal paste
```
cd ~ && sudo curl -O https://raw.githubusercontent.com/HAV0X1014/Pingbypass-Road-Warrior-Installer/main/pingbypassUniversalInstall.sh
cd ~ && sudo chmod +x pingbypassUniversalInstall.sh
cd ~ && sudo bash pingbypassUniversalInstall.sh
```

2. Follow the prompts printed into the console and type your answers to each.

3. Run `./launchpb` in a new terminal session, and use `launch [forge install ID number] -id` (forge install ID number is usually 1, so you can directly type `launch 1 -id`) to launch the Pingbypass server.

4. Connect 3arthh4ck to the server using the address and port supplied by playit.gg. If the address with words is too long, the IPv4 address supplied may work.

## Credits
zYongSheng_ - Making the inital guide to installing Pingbypass on NeverInstall and using Playit.gg to bypass port forwarding. This script is based on that idea.

3arthqu4ke - Making 3arthh4ck Pingbypass and help with Sandstar Pingbypass.

## Tips
If you're trying to use this guide on something like [Google Cloud Shell](https://shell.cloud.google.com), you may be limited on the ports you can use. For Cloud Shell VMs, you may be limited to 20, 21, 22, 80, 443, 2375, 2376, 3306, 8080, 9600, and 50051 for your open ports. I found that 2375 worked for my instances. You might also have to try using a VPN to place the Cloud Shell VM near the Minecraft server you want to play on.

- A good cheap VPS host for US servers (in Montreal) is Webdock. My affiliate link -> https://webdock.io/en?maff=wdaff--257

- A good cheap VPS host for nearly anywhere else is HostHatch. My affiliate link -> https://cloud.hosthatch.com/a/3718

## Contributing
If you are willing to contribute, please note what you changed, what distros you tested on, and keep changes as minimal as possible.
