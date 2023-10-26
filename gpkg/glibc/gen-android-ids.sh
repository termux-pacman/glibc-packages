#!/usr/bin/bash

APP_BASE_DIR="$1"
APP_BASE_DIR="${APP_BASE_DIR:=/data/data/com.termux/files}"
TOTAL_FILE="$2"
TOTAL_FILE="${TOTAL_FILE:=android_ids.h}"
READ_FILE="$3"
READ_FILE="${READ_FILE:=android_system_user_ids.h}"

echo '#ifndef _ANDROID_IDS' > $TOTAL_FILE
echo '#define _ANDROID_IDS' >> $TOTAL_FILE
echo '' >> $TOTAL_FILE
echo '#include "android_system_user_ids.h"' >> $TOTAL_FILE
echo '' >> $TOTAL_FILE
echo '#define AID_USER_OFFSET 100000' >> $TOTAL_FILE
echo '#define AID_OVERFLOWUID 65534' >> $TOTAL_FILE
echo '#define AID_ISOLATED_START 99000' >> $TOTAL_FILE
echo '#define AID_ISOLATED_END 99999' >> $TOTAL_FILE
echo '#define AID_APP_START 10000' >> $TOTAL_FILE
echo '#define AID_APP_END 19999' >> $TOTAL_FILE
echo '#define AID_CACHE_GID_START 20000' >> $TOTAL_FILE
echo '#define AID_CACHE_GID_END 29999' >> $TOTAL_FILE
echo '#define AID_EXT_GID_START 30000' >> $TOTAL_FILE
echo '#define AID_EXT_GID_END 39999' >> $TOTAL_FILE
echo '#define AID_EXT_CACHE_GID_START 40000' >> $TOTAL_FILE
echo '#define AID_EXT_CACHE_GID_END 49999' >> $TOTAL_FILE
echo '#define AID_SHARED_GID_START 50000' >> $TOTAL_FILE
echo '#define AID_SHARED_GID_END 59999' >> $TOTAL_FILE
echo '' >> $TOTAL_FILE
echo '#define AID_OEM_RESERVED_START 2900' >> $TOTAL_FILE
echo '#define AID_OEM_RESERVED_END 2999' >> $TOTAL_FILE
echo '#define AID_OEM_RESERVED_2_START 5000' >> $TOTAL_FILE
echo '#define AID_OEM_RESERVED_2_END 5999' >> $TOTAL_FILE
echo '' >> $TOTAL_FILE
echo 'struct IdRange {' >> $TOTAL_FILE
echo '    id_t start;' >> $TOTAL_FILE
echo '    id_t end;' >> $TOTAL_FILE
echo '};' >> $TOTAL_FILE
echo '' >> $TOTAL_FILE
echo 'static struct IdRange user_ranges[] = {' >> $TOTAL_FILE
echo '    { AID_APP_START, AID_APP_END },' >> $TOTAL_FILE
echo '    { AID_ISOLATED_START, AID_ISOLATED_END },' >> $TOTAL_FILE
echo '};' >> $TOTAL_FILE
echo '' >> $TOTAL_FILE
echo 'static struct IdRange group_ranges[] = {' >> $TOTAL_FILE
echo '    { AID_APP_START, AID_APP_END },' >> $TOTAL_FILE
echo '    { AID_CACHE_GID_START, AID_CACHE_GID_END },' >> $TOTAL_FILE
echo '    { AID_EXT_GID_START, AID_EXT_GID_END },' >> $TOTAL_FILE
echo '    { AID_EXT_CACHE_GID_START, AID_EXT_CACHE_GID_END },' >> $TOTAL_FILE
echo '    { AID_SHARED_GID_START, AID_SHARED_GID_END },' >> $TOTAL_FILE
echo '    { AID_ISOLATED_START, AID_ISOLATED_END },' >> $TOTAL_FILE
echo '};' >> $TOTAL_FILE
echo '' >> $TOTAL_FILE
echo 'struct android_id_info {' >> $TOTAL_FILE
echo '    const char *name;' >> $TOTAL_FILE
echo '    unsigned aid;' >> $TOTAL_FILE
echo '};' >> $TOTAL_FILE
echo '' >> $TOTAL_FILE
echo 'static struct android_id_info android_ids[] = {' >> $TOTAL_FILE
cat $READ_FILE | awk '{printf "    { \"" $2 "\", " $2 ", },\n"}' | sed -e 's/"AID_\(.*\)"/"\L\1"/' >> $TOTAL_FILE
echo '};' >> $TOTAL_FILE
echo '' >> $TOTAL_FILE
echo '#define android_id_count (sizeof(android_ids) / sizeof(android_ids[0]))' >> $TOTAL_FILE
echo '' >> $TOTAL_FILE
echo '// default paths for the application' >> $TOTAL_FILE
echo "#define APP_HOME_DIR \"${APP_BASE_DIR}/home\"" >> $TOTAL_FILE
echo "#define APP_PREFIX_DIR \"${APP_BASE_DIR}/usr\"" >> $TOTAL_FILE
echo '' >> $TOTAL_FILE
echo '#endif // _ANDROID_IDS' >> $TOTAL_FILE
