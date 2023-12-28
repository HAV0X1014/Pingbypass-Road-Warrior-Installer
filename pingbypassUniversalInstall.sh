#install wget
sudo apt install wget
yum install wget -y
pacman -Syu wget

#set some variables
internalip=$( ip -o route get to 10.0.0.0 | sed -n 's/.*src \([0-9.]\+\).*/\1/p' ) #WHAT THE FUCK
javadir=~/jdk1.8.0_321/bin
hmcdir=~/HeadlessMC
modsdir=~/.minecraft/mods
mcdir=~/.minecraft/versions/1.12.2
playitcheck=~./playit-linux-amd64
launch=~launchpb

#credits
echo $'brought to you by SoftWaren'
echo $'Welcome to Pingbyppass Setup'
echo $'Thanks to HAV0X1014, YongSheng109 and 3arthqu4ke.'

#tips
echo $'To prevent an insane minecraft account error, please go to https://account.live.com/activity and sign in your microsoft account'
sleep 2
echo $'If you get an error while logging into HeadlessMC, re-run the script.'
sleep 1

#asking for details
read -p $'What port would you like to use for Pingbypass? \n' openport
read -p $'What password would you like the Pingbypass server to use? \n' pass
read -p $'Input the email of the Minecraft account you want on the server.\n' email
read -p $'Input the password of the Minecraft account you want on the server.\n' password

#install java
	wget https://javadl.oracle.com/webapps/download/GetFile/1.8.0_321-b07/df5ad55fdd604472a86a45a217032c7d/linux-i586/jdk-8u321-linux-x64.tar.gz
	tar -xf jdk-8u321-linux-x64.tar.gz

#make config files, directories and input relevant configs
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

#download mods and hmc and move them to the proper places
	mkdir ~/.minecraft/mods -p
	wget https://github.com/SoftWaren1/Pingbypass-Client/releases/download/2.0.0/3arthh4ck-2.0.0.jar && mv 3arthh4ck-2.0.0.jar ~/.minecraft/mods
	wget https://github.com/3arthqu4ke/hmc-specifics/releases/download/v1.20.4-1.8.1/hmc-specifics-forge-1.20.4-1.8.1.jar && mv hmc-specifics-forge-1.20.4-1.8.1.jar ~/.minecraft/mods
	wget https://github.com/3arthqu4ke/HeadlessForge/releases/download/1.2.0/headlessforge-1.2.0.jar && mv headlessforge-1.2.0.jar ~/.minecraft/mods
	wget https://github.com/3arthqu4ke/headlessmc/releases/download/1.8.1/headlessmc-launcher-1.8.1.jar

#download minecraft and forge
	$javadir/java -jar headlessmc-launcher-1.5.2.jar --command download 1.12.2
	$javadir/java -jar headlessmc-launcher-1.5.2.jar --command forge 1.12.2
	$javadir/java -jar headlessmc-launcher-1.5.2.jar --command login $email $password


#download playit.gg
	wget https://github.com/playit-cloud/playit-agent/releases/download/v0.15.0/playit-linux-amd64 && chmod +x ./playit-linux-amd64

#make launch file for pb server
	touch launchpb && cat >>~/launchpb<<EOL
$javadir/java -jar headlessmc-launcher-1.5.2.jar --command $@
EOL
chmod +x launchpb

./playit-linux-amd64

#tell user how to use playit.gg and how to launch server
echo $"

**DO NOT CLOSE THIS TERMINAL UNLESS YOU ARE SURE YOU WILL NOT NEED IT**

To connect to your server, run './playit-linux-amd64'. When the browser opens, click where it says 'create a guest account' and then click 'Add tunnel'. For 'Tunnel Type' choose 'Minecraft Java' then click 'Next'. Set Local IPV4 to '$internalip' and Local Port to '$openport' Click 'Next' and then 'Create Tunnel'. Click the X in the top right of the box, and keep the browser window open.

Now open another terminal, and run HeadlessMC with './launchpb' and use 'launch [id number next to the forge install] -id' to launch the Pingbypass server.

On 3arthh4ck in the multiplayer menu, turn Pingbypass ON, and click the book to edit your connection details. For Proxy-IP put the IP of the tunnel from playit.gg, and for Proxy-Port, the port from playit.gg. In the last box, put in your Pingbypass password, which is $pass.

For your reference, your Internal IP is $internalip, your Minecraft port $openport, and pingbypass password is $pass"
