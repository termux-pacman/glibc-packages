#ifndef _ANDROID_PASSWD_GROUP_H
#define _ANDROID_PASSWD_GROUP_H

#include <pwd.h>
#include <grp.h>
#include "android_ids.h"

struct android_id_info * find_android_id_info_by_id(unsigned id);
struct android_id_info * find_android_id_info_by_name(const char* name);
int is_oem_id_android(id_t id);
int is_valid_id_android(id_t id, int is_group);
static id_t oem_id_from_name_android(const char* name);
static id_t app_id_from_name_android(const char* name, int is_group);
void get_name_by_uid_android(uid_t uid, char *name_u);
void get_name_by_gid_android(gid_t gid, char *name_g);
struct passwd * get_passwd_android(char* name, uid_t uid);
struct group * get_group_android(char* name, gid_t gid);
struct passwd * getpwuid_android(uid_t uid);
struct group * getgrgid_android(gid_t gid);
struct passwd * getpwnam_android(char* name);
struct group * getgrnam_android(char* name);

#endif // _ANDROID_PASSWD_GROUP_H
