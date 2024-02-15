{ pkgs, ... }:

{
    # https://github.com/NixOS/nixpkgs/issues/81418#issue-573452170
    environment.systemPackages = with pkgs; [
        ## EXPLOITATION

        # armitage
        # backdoor-factory
        # beef-xss
        # cisco-auditing-tool
        # cisco-global-exploiter
        # cisco-ocs
        # cisco-torch
        commix
        crackle
        exploitdb
        # jboss-autopwn
        linux-exploit-suggester
        # maltego-teeth
        metasploit
        msfpc
        routersploit
        # set
        shellnoob
        sqlmap
        thc-ipv6
        yersinia

        ## FORENSICS

        # autopsy
        # binwalk-full
        # bulk-extractor
        capstone
        # cuckoo
        # dc3dd
        ddrescue
        ddrescueview
        # dff
        # distorm3
        # dumpzilla
        ext4magic
        extundelete
        # galleta
        ghidra
        # guymager
        p0f
        pdf-parser
        # pdfid
        # pdgmail
        # peepdf
        # regripper
        sleuthkit
        # volatility
        # xplico

        # HARDWARE
        apktool
        arduino
        # bytecode-viewer
        dex2jar
        enjarify
        # sakis3g
        # smali

        ## INFORMATION GATHERING

        # ace-voip
        # amap
        arp-scan
        # automater
        # bing-ip2hosts
        braa
        # cdpsnarf
        # copy-router-config
        # dmitry
        # dnmap
        dnsenum
        # dnsmap
        dnsrecon
        # dotdotpwn
        enum4linux
        # eyewitness
        faraday-cli
        fierce
        firewalk
        # fragroute
        # fragrouter
        # golismero
        # goofile
        hping
        # ident-user-enum
        # lbd
        masscan
        # nbtscan-unixwiz
        nmap
        ntopng
        # osrframework
        # recon-ng
        smbmap
        # smtp-user-enum
        sn0int
        # sparta
        # sslcaudit
        sslsplit
        # sslstrip
        # sslyze
        # sublist3r
        theharvester
        testssl
        # twofi
        # unicornscan
        # urlcrazy
        wireshark
        # wol-e

        ## MAINTAINING ACCESS

        # cryptcat
        # cymothoa
        # dbd
        # dns2tcp
        httptunnel
        # intersect
        # nishang
        # polenum
        # powersploit
        pwnat
        # ridenum
        # sbd
        # shellter
        # u3-pwn
        # webshells
        # weevely
        # winexe

        ## PASSWORDS

        brutespray
        cewl
        chntpw
        cmospwd
        # creddump
        crowbar
        crunch
        # findmyhash
        # gpp-decrypt
        hash-identifier
        hashcat
        hashcat-utils
        hcxtools
        thc-hydra
        john
        johnny
        # keimpx
        # maskprocessor
        # multiforcer
        ncrack
        # oclgausscrack
        # ophcrack
        # pack
        # patator
        phrasendrescher
        # rainbowcrack
        # rcracki-mt
        # rsmangler
        seclists
        # sqldict
        # statsprocessor
        # thc-pptp-bruter
        truecrack
        # webscarab

        ## REPORTING

        # casefile
        cherrytree
        # cutycapt
        # dradis
        # magictree
        # metagoofil
        # nipper-ng
        # pipal
        # rdpy

        ## SNIFFING & SPOOFING

        bettercap
        dnschef
        dsniff
        # fiked
        # hamster-sidejack
        # hexinject
        # ismtp
        # isr-evilgrade
        mitmproxy
        # ohrwurm
        # protos-sip
        # rebind
        responder
        rshijack
        # rtpbreak
        # rtpinsertsound
        # rtpmixsound
        # sctpscan
        # siparmyknife
        sipp
        sipvicious
        sniffglue
        # sniffjoke
        # voiphopper
        # wifi-honey
        # xspy

        ## STRESS TESTING

        # dhcpig
        # funkload
        # iaxflood
        # inundator
        # inviteflood
        # ipv6-toolkit
        # mdk3
        reaverwps
        reaverwps-t6x
        # rtpflood
        slowhttptest
        # t50
        # termineter
        # thc-ssl-dos

        ## VULNERABILITY ANALYSIS

        # bbqsql
        # bed
        doona
        # hexorbase
        # jsql-injection
        lynis
        # openvas
        # oscanner
        # powerfuzzer
        # sfuzz
        # sidguesser
        # sqlninja
        # sqlsus
        # tnscmd10g
        # unix-privesc-check
        vulnix

        ## WEB APPLICATIONS

        apache-users
        # arachni
        # blindelephant
        burpsuite
        davtest
        # deblaze
        dirb
        # dirbuster
        # fimap
        gobuster
        # grabber
        hurl
        joomscan
        nikto
        padbuster
        # paros
        parsero
        plecost
        # skipfish
        # uniscan
        # w3af
        # webshag
        # webslayer
        websploit
        wfuzz
        whatweb
        wpscan
        xsser
        zap

        ## WIRELESS

        aircrack-ng
        asleap
        # bluelog
        # bluepot
        # blueranger
        # bluesnarfer
        bully
        cowpatty
        # eapmd5pass
        # fern-wifi-cracker
        # freeradius-wpe
        # ghost-phisher
        # giskismet
        gqrx
        # gr-scan
        # hostapd-wpe
        kalibrate-hackrf
        kalibrate-rtl
        # killerbee
        kismet
        mfcuk
        mfoc
        # mfterm
        multimon-ng
        pixiewps
        # pyrit
        redfang
        # rtlsdr-scanner
        # spooftooph
        # wifiphisher
        # wifitap
        wifite2

        ## NOT KALI BUT SECURITY-RELATED

        radare2
    ];
}
