
dir=`dirname $0`
cd $dir
export PATH=$PATH:$dir

source include-config.sh

LOG_DIR="${HOME}/tmp/fstests"

for dir in in ${LOG_DIR}/*; do
    [ -d ${dir} ] || continue

    #echo "dir: $dir"

    for file in ${dir}/*err; do
        if [ -s "$file" ]; then
            ls -l $file
        fi
    done
done

for file in ${LOG_DIR}/*/*.log; do
    grep "eviction" $file || true
done

