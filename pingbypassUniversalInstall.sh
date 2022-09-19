#set some variables
internalip=$( ip -o route get to 10.0.0.0 | sed -n 's/.*src \([0-9.]\+\).*/\1/p' ) #WHAT THE FUCK
javadir=~/jdk8u345-b01/bin
hmcdir=~/HeadlessMC
modsdir=~/.minecraft/mods
mcdir=~/.minecraft/versions/1.12.2
playitcheck=~playit-0.9.3
launch=~launchpb

#print the credits first, every installer ALWAYS has a stupid splash screen
echo $'brought to you by HAV0X of'
echo $'                                                                            
 ▄▄           ▐      ▗              ▗▄▄  ▝          ▐                       
▐▘ ▘ ▄▖ ▗▗▖  ▄▟  ▄▖ ▗▟▄  ▄▖  ▖▄     ▐ ▝▌▗▄  ▗▗▖  ▄▄ ▐▄▖ ▗ ▗ ▗▄▖  ▄▖  ▄▖  ▄▖ 
▝▙▄ ▝ ▐ ▐▘▐ ▐▘▜ ▐ ▝  ▐  ▝ ▐  ▛ ▘    ▐▄▟▘ ▐  ▐▘▐ ▐▘▜ ▐▘▜ ▝▖▞ ▐▘▜ ▝ ▐ ▐ ▝ ▐ ▝ 
  ▝▌▗▀▜ ▐ ▐ ▐ ▐  ▀▚  ▐  ▗▀▜  ▌      ▐    ▐  ▐ ▐ ▐ ▐ ▐ ▐  ▙▌ ▐ ▐ ▗▀▜  ▀▚  ▀▚ 
▝▄▟▘▝▄▜ ▐ ▐ ▝▙█ ▝▄▞  ▝▄ ▝▄▜  ▌      ▐   ▗▟▄ ▐ ▐ ▝▙▜ ▐▙▛  ▜  ▐▙▛ ▝▄▜ ▝▄▞ ▝▄▞ 
                                                 ▖▐      ▞  ▐               
                                                 ▝▘     ▝▘  ▝               
'
echo $'Sandstar Pingbypass can be found at http://discord.gg/5HVsNJrVWM'
sleep 2
echo $'If you get an error while logging into HeadlessMC, re-run the script.'
sleep 1

#make sure this is being run in the home dir and not anywhere else
if [ $PWD != ~ ]; then
	echo $'**This script MUST be run in the home directory!**\n**This script will NOT work elsewhere!**'
	exit 0
fi

#check for wget, and tell the user to install it
if ! command -v wget &> /dev/null
then
	echo $"wget is not installed. Install it with 'sudo apt install wget' if you are on a Debian or Ubuntu based system. If you are on an RPM (red hat) based system, use 'yum install wget -y'. For Arch based systems, use 'pacman -Syu wget'."
	exit 0
fi

#ask for user input for ip, port, password, and OS type
read -p $'What port would you like to use for Pingbypass? \n' openport
read -p $'What password would you like the Pingbypass server to use? \n' pass
read -p $'Input the email of the Minecraft account you want on the server.\n' email
read -p $'Input the password of the Minecraft account you want on the server.\n' password

#install java if it hasnt been installed before
if [ ! -d "$javadir" ]; then
	wget https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u345-b01/OpenJDK8U-jdk_x64_linux_hotspot_8u345b01.tar.gz
	tar -xf OpenJDK8U-jdk_x64_linux_hotspot_8u345b01.tar.gz
fi

#make config files, directories and input relevant configs if they dont exist
if [ ! -d "$hmcdir" ]; then
	mkdir ~/HeadlessMC -p && touch ~/HeadlessMC/config.properties && cat >> ~/HeadlessMC/config.properties<<EOL 
hmc.java.versions=$javadir/java
hmc.invert.jndi.flag=true
hmc.invert.lookup.flag=true
hmc.invert.lwjgl.flag=true
hmc.invert.pauls.flag=true
hmc.jvmargs=-Xmx1700M -Dheadlessforge.no.console=true
EOL

	mkdir ~/.minecraft/earthhack -p && touch ~/.minecraft/earthhack/pingbypass.properties && cat >> ~/.minecraft/earthhack/pingbypass.properties<<EOL
pb.server=true
pb.ip=$internalip
pb.port=$openport
pb.password=$pass
EOL
fi

#download mods and hmc and move them to the proper places if not already downloaded
if [ ! -d "$modsdir" ]; then
	mkdir ~/.minecraft/mods -p
	wget https://github.com/3arthqu4ke/3arthh4ck/releases/download/1.8.3/3arthh4ck-1.8.3-release.jar && mv 3arthh4ck-1.8.3-release.jar ~/.minecraft/mods
	wget https://github.com/3arthqu4ke/HMC-Specifics/releases/download/1.0.3/HMC-Specifics-1.12.2-b2-full.jar && mv HMC-Specifics-1.12.2-b2-full.jar ~/.minecraft/mods
	wget https://github.com/3arthqu4ke/HeadlessForge/releases/download/1.2.0/headlessforge-1.2.0.jar && mv headlessforge-1.2.0.jar ~/.minecraft/mods
	wget https://github.com/3arthqu4ke/HeadlessMc/releases/download/1.5.2/headlessmc-launcher-1.5.2.jar
fi

#download minecraft and forge if not already done and login
if [ ! -d "$mcdir" ]; then
	$javadir/java -jar headlessmc-launcher-1.5.2.jar --command download 1.12.2
	$javadir/java -jar headlessmc-launcher-1.5.2.jar --command forge 1.12.2
fi
	$javadir/java -jar headlessmc-launcher-1.5.2.jar --command login $email $password


#download playit.gg if it hasnt been already
if [ ! -d "$playitcheck" ]; then
	wget https://github.com/playit-cloud/playit-agent/releases/download/v0.9.3/playit-0.9.3 && chmod +x playit-0.9.3
fi

#make launch file for pb server if it hasnt been made already
if [ ! -d "$launch" ]; then
	touch launchpb && cat >>~/launchpb<<EOL
$javadir/java -jar headlessmc-launcher-1.5.2.jar --command $@
EOL
chmod +x launchpb
fi

#tell user how to use playit.gg and how to launch server
echo $"

**DO NOT CLOSE THIS TERMINAL UNLESS YOU ARE SURE YOU WILL NOT NEED IT**

To connect to your server, run './playit-0.9.3'. When the browser opens, click where it says 'create a guest account' and then click 'Add tunnel'. For 'Tunnel Type' choose 'Minecraft Java' then click 'Next'. Set Local IPV4 to '$internalip' and Local Port to '$openport' Click 'Next' and then 'Create Tunnel'. Click the X in the top right of the box, and keep the browser window open.

Now open another terminal, and run HeadlessMC with './launchpb' and use 'launch [id number next to the forge install] -id' to launch the Pingbypass server.

On 3arthh4ck in the multiplayer menu, turn Pingbypass ON, and click the book to edit your connection details. For Proxy-IP put the IP of the tunnel from playit.gg, and for Proxy-Port, the port from playit.gg. In the last box, put in your Pingbypass password, which is $pass.

For your reference, your Internal IP is $internalip, your Minecraft port $openport, and pingbypass password is $pass"
