/* - libfakehardlink.so
   A library that allows you to replace the `link` and `linkat` functions
   with fake ones that create symbolic links instead of hard ones.

   Version: 1.0
   By: @Maxython <mixython@gmail.com>
*/

#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <errno.h>
#include <limits.h>
#include <stdio.h>
#include <libgen.h>
#include <time.h>
#include <string.h>

const char* libfakehardlink_get_full_path_of_file(const char* file) {
	char path_file[PATH_MAX] = "";
	if (file[0] == '/') {
		sprintf(path_file, "%s", file);
	} else {
		getcwd(path_file, sizeof(path_file));
		sprintf(path_file, "%s/%s", path_file, file);
		sprintf(path_file, "%s/%s", realpath(dirname(strdup(path_file)), NULL), basename(strdup(path_file)));
	}
	return strdup(path_file);
}

const char* libfakehardlink_get_short_path(char* address, char* file) {
	char short_path[PATH_MAX] = "";
	char *token1, *token2;
	address = strdup(&address[1]);
        file = dirname(strdup(&file[1]));
        char *address_buff = dirname(strdup(address));
	while ((token2 = strsep(&file, "/"))) {
		if (address_buff)
			token1 = strsep(&address_buff, "/");
		else
			token1 = "";
		if (strcmp(token1, token2) != 0)
			sprintf(short_path, "../%s", strdup(short_path));
		else
			strsep(&address, "/");
	}
	if (address)
		sprintf(short_path, "%s%s", short_path, address);
	return strdup(short_path);
}

int linkat(int olddirfd, const char *oldpath, int newdirfd, const char *newpath, int flags) {
	if (access(newpath, F_OK) == 0) {
		errno = EEXIST;
		return -1;
	}

	if (access(oldpath, F_OK) == -1) {
		errno = EFAULT;
		return -1;
	}

	struct stat sb;
	if (stat(oldpath, &sb) == 0 && S_ISDIR(sb.st_mode)) {
		errno = EPERM;
		return -1;
	}

	const char* oldcwd = libfakehardlink_get_full_path_of_file(oldpath);
	if (strcmp(getenv("FAKEHARDLINK_DYNAMIC_LINKS"), "1") == 0) {
		char org_file_path[PATH_MAX];
		if (lstat(oldcwd, &sb) == 0 && !S_ISLNK(sb.st_mode)) {
			sprintf(org_file_path, "%s/.%s-fakehardlink-%ld", dirname(strdup(oldcwd)), basename(strdup(oldcwd)), time(NULL));
			rename(oldcwd, org_file_path);
			symlink(org_file_path, oldcwd);
		} else {
			readlink(oldcwd, org_file_path, sizeof(org_file_path));
		}
		oldcwd = org_file_path;
	} else {
		if (strcmp(getenv("FAKEHARDLINK_SHORT_LINKS"), "1") == 0)
			oldcwd = libfakehardlink_get_short_path((char*)oldcwd, (char*)libfakehardlink_get_full_path_of_file(newpath));
	}

	return symlinkat(oldcwd, newdirfd, newpath);
}

int link(const char *from, const char *to) {
	return linkat(AT_FDCWD, from, AT_FDCWD, to, 0);
}
