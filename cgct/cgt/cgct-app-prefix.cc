#include <stdlib.h>
#include <string.h>
#include "cgct-app-prefix.h"

#ifdef HOST_GENERATOR_FILE
#include "config.h"
#define GENERATOR_FILE 1
#else
#include "bconfig.h"
#endif
#include "system.h"

#define CGCT_DEFAULT_PREFIX "/data/data/com.termux/files/usr/glibc"

#define CGCT_GETENV_PREFIX getenv("CGCT_APP_PREFIX")

char* cgct_app_prefix(const char* path) {
	if (CGCT_GETENV_PREFIX)
		return concat(CGCT_GETENV_PREFIX, path, NULL);
	else
		return concat(CGCT_DEFAULT_PREFIX, path, NULL);
}
