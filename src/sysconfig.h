/* src/sysconfig.h.  Generated automatically by configure.  */
/* src/sysconfig.h.in.  Generated automatically from configure.in by autoheader.  */

/* Define if on AIX 3.
   System headers sometimes define this.
   We just want to avoid a redefinition error message.  */
#ifndef _ALL_SOURCE
/* #undef _ALL_SOURCE */
#endif

/* Define to empty if the keyword does not work.  */
/* #undef const */

/* Define if you have the getmntent function.  */
#define HAVE_GETMNTENT 1

/* Define if your struct stat has st_blocks.  */
/* #undef HAVE_ST_BLOCKS */

/* Define if utime(file, NULL) sets file's timestamp to the present.  */
#define HAVE_UTIME_NULL 1

/* Define as __inline if that's what the C compiler calls it.  */
/* #undef inline */

/* Define to `int' if <sys/types.h> doesn't define.  */
/* #undef mode_t */

/* Define to `long' if <sys/types.h> doesn't define.  */
/* #undef off_t */

/* Define to `int' if <sys/types.h> doesn't define.  */
/* #undef pid_t */

/* Define if you need to in order for stat and other things to work.  */
/* #undef _POSIX_SOURCE */

/* Define as the return type of signal handlers (int or void).  */
#define RETSIGTYPE void

/* Define if you have the ANSI C header files.  */
#define STDC_HEADERS 1

/* Define if you can safely include both <sys/time.h> and <time.h>.  */
#define TIME_WITH_SYS_TIME 1

/* Define if your <sys/time.h> declares struct tm.  */
/* #undef TM_IN_SYS_TIME */

/* Define if the X Window System is missing or not being used.  */
/* #undef X_DISPLAY_MISSING */

/* Define if you have the Andrew File System.  */
/* #undef AFS */

/* Define if there is no specific function for reading the list of
   mounted filesystems.  fread will be used to read /etc/mnttab.  [SVR2]  */
/* #undef MOUNTED_FREAD */

/* Define if (like SVR2) there is no specific function for reading the
   list of mounted filesystems, and your system has these header files:
   <sys/fstyp.h> and <sys/statfs.h>.  [SVR3]  */
/* #undef MOUNTED_FREAD_FSTYP */

/* Define if there is a function named getfsstat for reading the list
   of mounted filesystems.  [DEC Alpha running OSF/1]  */
/* #undef MOUNTED_GETFSSTAT */

/* Define if there is a function named getmnt for reading the list of
   mounted filesystems.  [Ultrix]  */
/* #undef MOUNTED_GETMNT */

/* Define if there is a function named getmntent for reading the list
   of mounted filesystems, and that function takes a single argument.
   [4.3BSD, SunOS, HP-UX, Dynix, Irix]  */
#define MOUNTED_GETMNTENT1 1

/* Define if there is a function named getmntent for reading the list of
   mounted filesystems, and that function takes two arguments.  [SVR4]  */
/* #undef MOUNTED_GETMNTENT2 */

/* Define if there is a function named getmntinfo for reading the list
   of mounted filesystems.  [4.4BSD]  */
/* #undef MOUNTED_GETMNTINFO */

/* Define if there is a function named listmntent that can be used to
   list all mounted filesystems. [UNICOS] */
/* #undef MOUNTED_LISTMNTENT */

/* Define if there is a function named mntctl that can be used to read
   the list of mounted filesystems, and there is a system header file
   that declares `struct vmount.'  [AIX]  */
/* #undef MOUNTED_VMOUNT */

/*  Define if  statfs takes 3 args.  [DEC Alpha running OSF/1]  */
/* #undef STAT_STATFS3_OSF1 */

/* Define if there is no specific function for reading filesystems usage
   information and you have the <sys/filsys.h> header file.  [SVR2]  */
/* #undef STAT_READ_FILSYS */

/* Define if statfs takes 2 args and struct statfs has a field named f_bsize.
   [4.3BSD, SunOS 4, HP-UX, AIX PS/2]  */
#ifndef DREAMCAST
#define STAT_STATFS2_BSIZE 1
#else
/* #undef STAT_STATFS2_BSIZE */
#endif

/* Define if statfs takes 2 args and struct statfs has a field named f_fsize.
   [4.4BSD, NetBSD]  */
/* #undef STAT_STATFS2_FSIZE */

/* Define if statfs takes 2 args and the second argument has
   type struct fs_data.  [Ultrix]  */
/* #undef STAT_STATFS2_FS_DATA */

/* Define if statfs takes 4 args.  [SVR3, Dynix, Irix, Dolphin]  */
/* #undef STAT_STATFS4 */

/* Define if there is a function named statvfs.  [SVR4]  */
/* #undef STAT_STATVFS */

/* Define if the block counts reported by statfs may be truncated to 2GB
   and the correct values may be stored in the f_spare array.
   [SunOS 4.1.2, 4.1.3, and 4.1.3_U1 are reported to have this problem.
   SunOS 4.1.1 seems not to be affected.]  */
/* #undef STATFS_TRUNCATES_BLOCK_COUNTS */

/* The number of bytes in a __int64.  */
#define SIZEOF___INT64 8

/* The number of bytes in a char.  */
#define SIZEOF_CHAR 1

/* The number of bytes in a int.  */
#define SIZEOF_INT 4

/* The number of bytes in a long.  */
#define SIZEOF_LONG 4

/* The number of bytes in a long long.  */
#define SIZEOF_LONG_LONG 8

/* The number of bytes in a short.  */
#define SIZEOF_SHORT 2

/* Define if you have the bcopy function.  */
#define HAVE_BCOPY 1

/* Define if you have the cfmakeraw function.  */
/* #undef HAVE_CFMAKERAW */

/* Define if you have the endgrent function.  */
#define HAVE_ENDGRENT 1

/* Define if you have the endpwent function.  */
#define HAVE_ENDPWENT 1

/* Define if you have the fchdir function.  */
#define HAVE_FCHDIR 1

/* Define if you have the ftime function.  */
#define HAVE_FTIME 1

/* Define if you have the ftruncate function.  */
#define HAVE_FTRUNCATE 1

/* Define if you have the getcwd function.  */
#define HAVE_GETCWD 1

/* Define if you have the getmntinfo function.  */
/* #undef HAVE_GETMNTINFO */

/* Define if you have the getopt function.  */
#define HAVE_GETOPT 1

/* Define if you have the gettimeofday function.  */
/* #undef HAVE_GETTIMEOFDAY  */

/* Define if you have the isascii function.  */
#define HAVE_ISASCII 1

/* Define if you have the lchown function.  */
#define HAVE_LCHOWN 1

/* Define if you have the listmntent function.  */
/* #undef HAVE_LISTMNTENT */

/* Define if you have the memcpy function.  */
#define HAVE_MEMCPY 1

/* Define if you have the mkdir function.  */
#define HAVE_MKDIR 1

/* Define if you have the mkfifo function.  */
#define HAVE_MKFIFO 1

/* Define if you have the readdir_r function.  */
/* #undef HAVE_READDIR_R */

/* Define if you have the rmdir function.  */
#define HAVE_RMDIR 1

/* Define if you have the select function.  */
#define HAVE_SELECT 1

/* Define if you have the setitimer function.  */
#define HAVE_SETITIMER 1

/* Define if you have the sigaction function.  */
#define HAVE_SIGACTION 1

/* Define if you have the strchr function.  */
#define HAVE_STRCHR 1

/* Define if you have the strdup function.  */
#define HAVE_STRDUP 1

/* Define if you have the strerror function.  */
#define HAVE_STRERROR 1

/* Define if you have the strrchr function.  */
#define HAVE_STRRCHR 1

/* Define if you have the strstr function.  */
#define HAVE_STRSTR 1

/* Define if you have the tcgetattr function.  */
#define HAVE_TCGETATTR 1

/* Define if you have the vfprintf function.  */
#define HAVE_VFPRINTF 1

/* Define if you have the vprintf function.  */
#define HAVE_VPRINTF 1

/* Define if you have the vsprintf function.  */
#define HAVE_VSPRINTF 1

/* Define if you have the <SDL/SDL.h> header file.  */
/* #undef HAVE_SDL_SDL_H */

/* Define if you have the <curses.h> header file.  */
#define HAVE_CURSES_H 1

/* Define if you have the <cybergraphx/cybergraphics.h> header file.  */
/* #undef HAVE_CYBERGRAPHX_CYBERGRAPHICS_H */

/* Define if you have the <ddraw.h> header file.  */
/* #undef HAVE_DDRAW_H */

/* Define if you have the <devices/ahi.h> header file.  */
/* #undef HAVE_DEVICES_AHI_H */

/* Define if you have the <dirent.h> header file.  */
#define HAVE_DIRENT_H 1

/* Define if you have the <dmedia/audio.h> header file.  */
/* #undef HAVE_DMEDIA_AUDIO_H */

/* Define if you have the <fcntl.h> header file.  */
#define HAVE_FCNTL_H 1

/* Define if you have the <features.h> header file.  */
#define HAVE_FEATURES_H 1

/* Define if you have the <getopt.h> header file.  */
#define HAVE_GETOPT_H 1

/* Define if you have the <libraries/cybergraphics.h> header file.  */
/* #undef HAVE_LIBRARIES_CYBERGRAPHICS_H */

/* Define if you have the <machine/joystick.h> header file.  */
/* #undef HAVE_MACHINE_JOYSTICK_H */

/* Define if you have the <machine/soundcard.h> header file.  */
/* #undef HAVE_MACHINE_SOUNDCARD_H */

/* Define if you have the <mntent.h> header file.  */
#define HAVE_MNTENT_H 1

/* Define if you have the <mnttab.h> header file.  */
/* #undef HAVE_MNTTAB_H */

/* Define if you have the <ncurses.h> header file.  */
#define HAVE_NCURSES_H 1

/* Define if you have the <ndir.h> header file.  */
/* #undef HAVE_NDIR_H */

/* Define if you have the <posix_opt.h> header file.  */
/* #undef HAVE_POSIX_OPT_H */

/* Define if you have the <string.h> header file.  */
#define HAVE_STRING_H 1

/* Define if you have the <strings.h> header file.  */
#ifndef DREAMCAST
#define HAVE_STRINGS_H 1
#else
/* #undef HAVE_STRINGS_H */
#endif

/* Define if you have the <sun/audioio.h> header file.  */
/* #undef HAVE_SUN_AUDIOIO_H */

/* Define if you have the <sys/audioio.h> header file.  */
/* #undef HAVE_SYS_AUDIOIO_H */

/* Define if you have the <sys/dir.h> header file.  */
/* #undef HAVE_SYS_DIR_H */

/* Define if you have the <sys/filsys.h> header file.  */
/* #undef HAVE_SYS_FILSYS_H */

/* Define if you have the <sys/fs/s5param.h> header file.  */
/* #undef HAVE_SYS_FS_S5PARAM_H */

/* Define if you have the <sys/fs_types.h> header file.  */
/* #undef HAVE_SYS_FS_TYPES_H */

/* Define if you have the <sys/fstyp.h> header file.  */
/* #undef HAVE_SYS_FSTYP_H */

/* Define if you have the <sys/ioctl.h> header file.  */
#define HAVE_SYS_IOCTL_H 1

/* Define if you have the <sys/ipc.h> header file.  */
#define HAVE_SYS_IPC_H 1

/* Define if you have the <sys/mount.h> header file.  */
#ifndef DREAMCAST
#define HAVE_SYS_MOUNT_H 1
#else
/* #undef HAVE_SYS_MOUNT_H */
#endif

/* Define if you have the <sys/ndir.h> header file.  */
/* #undef HAVE_SYS_NDIR_H */

/* Define if you have the <sys/param.h> header file.  */
#define HAVE_SYS_PARAM_H 1

/* Define if you have the <sys/shm.h> header file.  */
#define HAVE_SYS_SHM_H 1

/* Define if you have the <sys/soundcard.h> header file.  */
#define HAVE_SYS_SOUNDCARD_H 1

/* Define if you have the <sys/stat.h> header file.  */
#define HAVE_SYS_STAT_H 1

/* Define if you have the <sys/statfs.h> header file.  */
#ifndef DREAMCAST
#define HAVE_SYS_STATFS_H 1
#else
/* #undef HAVE_SYS_STATFS_H  */
#endif

/* Define if you have the <sys/statvfs.h> header file.  */
/* #undef HAVE_SYS_STATVFS_H */

/* Define if you have the <sys/termios.h> header file.  */
#define HAVE_SYS_TERMIOS_H 1

/* Define if you have the <sys/time.h> header file.  */
#define HAVE_SYS_TIME_H 1

/* Define if you have the <sys/types.h> header file.  */
#define HAVE_SYS_TYPES_H 1

/* Define if you have the <sys/utime.h> header file.  */
/* #undef HAVE_SYS_UTIME_H */

/* Define if you have the <sys/vfs.h> header file.  */
#ifndef DREAMCAST
#define HAVE_SYS_VFS_H 1
#else
/* #undef HAVE_SYS_VFS_H */
#endif

/* Define if you have the <unistd.h> header file.  */
#define HAVE_UNISTD_H 1

/* Define if you have the <utime.h> header file.  */
#define HAVE_UTIME_H 1

/* Define if you have the <values.h> header file.  */
/* #undef HAVE_VALUES_H */

/* Define if you have the <windows.h> header file.  */
/* #undef HAVE_WINDOWS_H */

#ifdef WIN32
#define random() (rand())
#endif

#ifdef DREAMCAST
#include<kos.h>
#include<sys/stat.h>
#include<utime.h>
#define dup(a) (int)fs_dup((file_t)a)
#define access(a,b) 0
#define mkdir(a,b) fs_mkdir(a)
#define rmdir(a) fs_rmdir(a)
#define chmod(a,b) 0
#define utime(a,b) 0
#define random() (rand())
#define creat(x,y) open("T:creat",O_CREAT|O_WRONLY|O_TRUNC)
#define tmpnam(a) "/ram/tmp"
#endif

#ifdef PSP
#include <pspincludes.h>
#endif
