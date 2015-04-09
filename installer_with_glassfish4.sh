echo Play Framework installer for glassfish 4

color='\033[0;36m'
NC='\033[0m' # No Color
echo -e "${color}1. Turn another glassfish processes down on Unix if exists${NC}"
ps -ef | grep glassfish | grep -v grep | awk '{print $2}' | xargs kill -9
cd ..
echo -e "${color}2. Installing glassfish 4 server${NC}"
wget http://dlc.sun.com.edgesuite.net/glassfish/4.1/release/glassfish-4.1.zip
unzip glassfish-4.1*zip
rm -rf rm -rf glassfish-4.1.zip
echo -e "${color}3. Installing Play framework on glassfish${NC}"
wget http://downloads.typesafe.com/play/2.2.6/play-2.2.6.zip
unzip play-2.2.6.zip
rm -rf play-2.2.6.zip
find play-2.2.6/repository/local/ '*.jar' -exec cp -vuni '{}' "glassfish4/glassfish/domains/domain1/lib/" ";"
find play-2.2.6/repository/local/ -iname \*.jar -exec cp {} glassfish4/glassfish/domains/domain1/lib/ \;
rm -rf play-2.2.6
echo -e "${color}4. Installing new Play Scala Application${NC}"
wget http://downloads.typesafe.com/typesafe-activator/1.2.12/typesafe-activator-1.2.12-minimal.zip
unzip typesafe-activator-1.2.12-minimal.zip
rm -rf typesafe-activator-1.2.12-minimal.zip
cd activator-1.2.12-minimal
./activator new sport-api play-scala
play_act_file=$(pwd)/sport-api/conf/application.conf
cd ..
echo -e "${color}5. Starting glassfish server${NC}"
glassfish4/glassfish/bin/asadmin stop-domain
glassfish4/glassfish/bin/asadmin start-domain
echo -e "${color}6. Configuring glassfish to use play application${NC}"
echo PLAY_APP_FILE= $play_act_file
glassfish4/glassfish/bin/asadmin create-jvm-options -Dconfig.file=$play_act_file

echo -e "${color}8. DONE ${NC}" 
