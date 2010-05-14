

all: 
	make -C fsstress/
	make -C ntfs3g_posix/pjd-fstest/
	make -C ql-fstest/

clean:
	make -C fsstress/ clean
	make -C ntfs3g_posix/pjd-fstest/ clean
	make -C ql-fstest/ clean

