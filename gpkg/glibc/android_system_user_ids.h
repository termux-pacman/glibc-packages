#define AID_ROOT 0 /* traditional unix root user */
#define AID_DAEMON 1 /* Traditional unix daemon owner. */
#define AID_BIN 2    /* Traditional unix binaries owner. */
#define AID_SYS 3    /* A group with the same gid on Linux/macOS/Android. */
#define AID_SYSTEM 1000 /* system server */
#define AID_RADIO 1001           /* telephony subsystem, RIL */
#define AID_BLUETOOTH 1002       /* bluetooth subsystem */
#define AID_GRAPHICS 1003        /* graphics devices */
#define AID_INPUT 1004           /* input devices */
#define AID_AUDIO 1005           /* audio devices */
#define AID_CAMERA 1006          /* camera devices */
#define AID_LOG 1007             /* log devices */
#define AID_COMPASS 1008         /* compass device */
#define AID_MOUNT 1009           /* mountd socket */
#define AID_WIFI 1010            /* wifi subsystem */
#define AID_ADB 1011             /* android debug bridge (adbd) */
#define AID_INSTALL 1012         /* group for installing packages */
#define AID_MEDIA 1013           /* mediaserver process */
#define AID_DHCP 1014            /* dhcp client */
#define AID_SDCARD_RW 1015       /* external storage write access */
#define AID_VPN 1016             /* vpn system */
#define AID_KEYSTORE 1017        /* keystore subsystem */
#define AID_USB 1018             /* USB devices */
#define AID_DRM 1019             /* DRM server */
#define AID_MDNSR 1020           /* MulticastDNSResponder (service discovery) */
#define AID_GPS 1021             /* GPS daemon */
#define AID_UNUSED1 1022         /* deprecated, DO NOT USE */
#define AID_MEDIA_RW 1023        /* internal media storage write access */
#define AID_MTP 1024             /* MTP USB driver access */
#define AID_UNUSED2 1025         /* deprecated, DO NOT USE */
#define AID_DRMRPC 1026          /* group for drm rpc */
#define AID_NFC 1027             /* nfc subsystem */
#define AID_SDCARD_R 1028        /* external storage read access */
#define AID_CLAT 1029            /* clat part of nat464 */
#define AID_LOOP_RADIO 1030      /* loop radio devices */
#define AID_MEDIA_DRM 1031       /* MediaDrm plugins */
#define AID_PACKAGE_INFO 1032    /* access to installed package details */
#define AID_SDCARD_PICS 1033     /* external storage photos access */
#define AID_SDCARD_AV 1034       /* external storage audio/video access */
#define AID_SDCARD_ALL 1035      /* access all users external storage */
#define AID_LOGD 1036            /* log daemon */
#define AID_SHARED_RELRO 1037    /* creator of shared GNU RELRO files */
#define AID_DBUS 1038            /* dbus-daemon IPC broker process */
#define AID_TLSDATE 1039         /* tlsdate unprivileged user */
#define AID_MEDIA_EX 1040        /* mediaextractor process */
#define AID_AUDIOSERVER 1041     /* audioserver process */
#define AID_METRICS_COLL 1042    /* metrics_collector process */
#define AID_METRICSD 1043        /* metricsd process */
#define AID_WEBSERV 1044         /* webservd process */
#define AID_DEBUGGERD 1045       /* debuggerd unprivileged user */
#define AID_MEDIA_CODEC 1046     /* mediacodec process */
#define AID_CAMERASERVER 1047    /* cameraserver process */
#define AID_FIREWALL 1048        /* firewalld process */
#define AID_TRUNKS 1049          /* trunksd process (TPM daemon) */
#define AID_NVRAM 1050           /* Access-controlled NVRAM */
#define AID_DNS 1051             /* DNS resolution daemon (system: netd) */
#define AID_DNS_TETHER 1052      /* DNS resolution daemon (tether: dnsmasq) */
#define AID_WEBVIEW_ZYGOTE 1053  /* WebView zygote process */
#define AID_VEHICLE_NETWORK 1054 /* Vehicle network service */
#define AID_MEDIA_AUDIO 1055     /* GID for audio files on internal media storage */
#define AID_MEDIA_VIDEO 1056     /* GID for video files on internal media storage */
#define AID_MEDIA_IMAGE 1057     /* GID for image files on internal media storage */
#define AID_TOMBSTONED 1058      /* tombstoned user */
#define AID_MEDIA_OBB 1059       /* GID for OBB files on internal media storage */
#define AID_ESE 1060             /* embedded secure element (eSE) subsystem */
#define AID_OTA_UPDATE 1061      /* resource tracking UID for OTA updates */
#define AID_AUTOMOTIVE_EVS 1062  /* Automotive rear and surround view system */
#define AID_LOWPAN 1063          /* LoWPAN subsystem */
#define AID_HSM 1064             /* hardware security module subsystem */
#define AID_RESERVED_DISK 1065   /* GID that has access to reserved disk space */
#define AID_STATSD 1066          /* statsd daemon */
#define AID_INCIDENTD 1067       /* incidentd daemon */
#define AID_SECURE_ELEMENT 1068  /* secure element subsystem */
#define AID_LMKD 1069            /* low memory killer daemon */
#define AID_LLKD 1070            /* live lock daemon */
#define AID_IORAPD 1071          /* input/output readahead and pin daemon */
#define AID_GPU_SERVICE 1072     /* GPU service daemon */
#define AID_NETWORK_STACK 1073   /* network stack service */
#define AID_GSID 1074            /* GSI service daemon */
#define AID_FSVERITY_CERT 1075   /* fs-verity key ownership in keystore */
#define AID_CREDSTORE 1076       /* identity credential manager service */
#define AID_EXTERNAL_STORAGE 1077 /* Full external storage access including USB OTG volumes */
#define AID_EXT_DATA_RW 1078      /* GID for app-private data directories on external storage */
#define AID_EXT_OBB_RW 1079       /* GID for OBB directories on external storage */
#define AID_CONTEXT_HUB 1080      /* GID for access to the Context Hub */
#define AID_VIRTUALIZATIONSERVICE 1081 /* VirtualizationService daemon */
#define AID_ARTD 1082             /* ART Service daemon */
#define AID_UWB 1083              /* UWB subsystem */
#define AID_THREAD_NETWORK 1084   /* Thread Network subsystem */
#define AID_DICED 1085            /* Android's DICE daemon */
#define AID_DMESGD 1086           /* dmesg parsing daemon for kernel report collection */
#define AID_JC_WEAVER 1087        /* Javacard Weaver HAL - to manage omapi ARA rules */
#define AID_JC_STRONGBOX 1088     /* Javacard Strongbox HAL - to manage omapi ARA rules */
#define AID_JC_IDENTITYCRED 1089  /* Javacard Identity Cred HAL - to manage omapi ARA rules */
#define AID_SDK_SANDBOX 1090      /* SDK sandbox virtual UID */
#define AID_SECURITY_LOG_WRITER 1091 /* write to security log */
#define AID_PRNG_SEEDER 1092         /* PRNG seeder daemon */
#define AID_SHELL 2000 /* adb and debug shell user */
#define AID_CACHE 2001 /* cache access */
#define AID_DIAG 2002  /* access to diagnostic resources */
#define AID_NET_BT_ADMIN 3001 /* bluetooth: create any socket */
#define AID_NET_BT 3002       /* bluetooth: create sco, rfcomm or l2cap sockets */
#define AID_INET 3003         /* can create AF_INET and AF_INET6 sockets */
#define AID_NET_RAW 3004      /* can create raw INET sockets */
#define AID_NET_ADMIN 3005    /* can configure interfaces and routing tables. */
#define AID_NET_BW_STATS 3006 /* read bandwidth statistics */
#define AID_NET_BW_ACCT 3007  /* change bandwidth statistics accounting */
#define AID_READPROC 3009     /* Allow /proc read access */
#define AID_WAKELOCK 3010     /* Allow system wakelock read/write access */
#define AID_UHID 3011         /* Allow read/write to /dev/uhid node */
#define AID_READTRACEFS 3012  /* Allow tracefs read */
#define AID_EVERYBODY 9997 /* shared between all apps in the same profile */
#define AID_MISC 9998      /* access to misc storage */
#define AID_NOBODY 9999
