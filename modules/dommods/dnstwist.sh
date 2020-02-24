#!/bin/bash
ORNG='\033[0;33m'
NC='\033[0m'
W='\033[1;37m'
LP='\033[1;35m'
YLW='\033[1;33m'
LBBLUE='\e[104m'
listing(){
    echo -e "${YLW}"
    cat files/pingtest.pass
    echo -e "${NC}"
}
check(){
    if [[ -d '/opt/sifter/results/DnsTwist' ]]; then
        echo ""
    else
        mkdir /opt/sifter/results/DnsTwist
    fi
}

cd /opt/dnstwist
echo -e "${ORNG}DnsTwist"
echo -e "*********${NC}"
check
listing
echo -e "${W}Please enter your target${NC}"
read TARGET
sleep 1
mkdir /opt/sifter/results/DnsTwist/${TARGET}
echo -e "${RED}Performing 'registered' test${NC}"
./dnstwist.py --registered ${TARGET} > /opt/sifter/results/DnsTwist/${TARGET}/registered_test.csv
echo -e "${RED}Performing ssdeep test${NC}"
./dnstwist.py --ssdeep ${TARGET} > /opt/sifter/results/DnsTwist/${TARGET}/ssdeep_test.csv
echo -e "${RED}Performing GeoIP test${NC}"
./dnstwist.py --geoip ${TARGET} > /opt/sifter/results/DnsTwist/${TARGET}/geoip_test.csv
echo -e "${RED}Performing mxcheck test${NC}"
./dnstwist.py --mxcheck ${TARGET} > /opt/sifter/results/DnsTwist/${TARGET}/mxcheck_test.csv
echo -e "${RED}Performing TLD test${NC}"
./dnstwist.py --tld dictionaries/common_tlds.dict ${TARGET} > /opt/sifter/results/DnsTwist/${TARGET}/tld_test.csv
echo -e "${W}"
figlet -f mini "Done"
echo -e "Results saved to /opt/sifter/results/DnsTwist/${TARGET}${NC}"
cd /opt/sifter
./modules/module.sh